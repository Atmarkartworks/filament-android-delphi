/*
 * Copyright (C) 2018 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.gyabinet.filament.mylibrary;
/**
 * Filament-based renderer utility for rendering an animated triangle.
 * This class provides static methods to manage Filament rendering lifecycle.
 * Usage:
 *   MyLibMainActivityUtil.create(activity);
 *   // ... later ...
 *   MyLibMainActivityUtil.pause(activity);
 *   MyLibMainActivityUtil.resume(activity);
 *   MyLibMainActivityUtil.destroy(activity);
 */
import android.animation.ValueAnimator;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.res.AssetFileDescriptor;
import android.opengl.Matrix;
import android.util.Log;
import android.view.Choreographer;
import android.view.Gravity;
import android.view.Surface;
import android.view.SurfaceView;
import android.view.ViewGroup;
import android.view.animation.LinearInterpolator;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.google.android.filament.*;
import com.google.android.filament.RenderableManager.*;
import com.google.android.filament.VertexBuffer.*;
import com.google.android.filament.android.DisplayHelper;
import com.google.android.filament.android.FilamentHelper;
import com.google.android.filament.android.UiHelper;

import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.Channels;


public class MyLibMainActivityUtil {

    private static final String TAG = "MyLibMainActivityUtil";

    // Filament initialization
    static {
        Filament.init();
    }

    // The View we want to render into
    private static SurfaceView surfaceView;
    // UiHelper is provided by Filament to manage SurfaceView and SurfaceTexture
    private static UiHelper uiHelper;
    // DisplayHelper is provided by Filament to manage the display
    private static DisplayHelper displayHelper;
    // Choreographer is used to schedule new frames
    private static Choreographer choreographer;

    // Engine creates and destroys Filament resources
    private static Engine engine;
    // A renderer instance is tied to a single surface (SurfaceView, TextureView, etc.)
    private static Renderer renderer;
    // A scene holds all the renderable, lights, etc. to be drawn
    private static Scene scene;
    // A view defines a viewport, a scene and a camera for rendering
    private static View view;
    // Should be pretty obvious :)
    private static Camera camera;

    private static Material material;
    private static VertexBuffer vertexBuffer;
    private static IndexBuffer indexBuffer;

    // Filament entity representing a renderable object
    private static int renderable = 0;

    // A swap chain is Filament's representation of a surface
    private static SwapChain swapChain;

    // Performs the rendering and schedules new frames
    private static FrameCallback frameScheduler;

    private static ValueAnimator animator;

    // State management
    private static boolean isInitialized = false;
    private static Activity currentActivity;

    /**
     * Creates and initializes the Filament renderer with a SurfaceView.
     * Call this method from the Activity where you want to display Filament rendering.
     *
     * @param activity The Activity to attach the renderer to
     */
    public static void create(final Activity activity) {
        if (activity == null) {
            Log.e(TAG, "Activity is null");
            return;
        }

        if (isInitialized && currentActivity == activity) {
            Log.w(TAG, "Renderer already initialized for this activity");
            return;
        }

        if (currentActivity != null && currentActivity != activity) {
            destroy(currentActivity);
        }

        currentActivity = activity;

        activity.runOnUiThread(() -> {
            try {
                if (surfaceView != null) {
                    return;
                }

                choreographer = Choreographer.getInstance();
                displayHelper = new DisplayHelper(activity);

                surfaceView = new SurfaceView(activity);

                @SuppressLint("SetTextI18n")
                TextView textView = new TextView(activity);
                textView.setText("This TextView is under the Filament SurfaceView.");
                textView.setTextSize(32.0f);
                float density = activity.getResources().getDisplayMetrics().density;
                textView.setPadding((int)(16 * density), 0, (int)(16 * density), 0);

                FrameLayout container = new FrameLayout(activity);
                container.addView(textView, new FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.MATCH_PARENT,
                    FrameLayout.LayoutParams.WRAP_CONTENT,
                    Gravity.CENTER_VERTICAL
                ));
                container.addView(surfaceView);

                FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
                );

                activity.addContentView(container, layoutParams);

                setupSurfaceView();
                setupFilament();
                setupView();
                setupScene();

                frameScheduler = getFrameScheduler();

                isInitialized = true;
                Log.d(TAG, "Renderer initialized successfully");

                // Start rendering immediately
                resume(activity);
            } catch (Exception e) {
                Log.e(TAG, "Error creating renderer", e);
                isInitialized = false;
            }
        });
    }

    /**
     * Pauses the renderer (stops frame callbacks and animation).
     *
     * @param activity The Activity (for thread safety)
     */
    public static void pause(final Activity activity) {
        if (activity == null || !isInitialized) {
            return;
        }

        activity.runOnUiThread(() -> {
            try {
                if (choreographer != null && frameScheduler != null) {
                    choreographer.removeFrameCallback(frameScheduler);
                }
                if (animator != null) {
                    animator.pause();
                }
                Log.d(TAG, "Renderer paused");
            } catch (Exception e) {
                Log.e(TAG, "Error pausing renderer", e);
            }
        });
    }

    /**
     * Resumes the renderer (restarts frame callbacks and animation).
     *
     * @param activity The Activity (for thread safety)
     */
    public static void resume(final Activity activity) {
        if (activity == null || !isInitialized) {
            return;
        }

        activity.runOnUiThread(() -> {
            try {
                if (choreographer != null && frameScheduler != null) {
                    choreographer.removeFrameCallback(frameScheduler);
                }
                if (choreographer != null && frameScheduler != null) {
                    choreographer.postFrameCallback(frameScheduler);
                }
                if (animator != null) {
                    animator.resume();
                }
                Log.d(TAG, "Renderer resumed");
            } catch (Exception e) {
                Log.e(TAG, "Error resuming renderer", e);
            }
        });
    }

    /**
     * Destroys the renderer and cleans up all Filament resources.
     *
     * @param activity The Activity (for thread safety)
     */
    public static void destroy(final Activity activity) {
        if (!isInitialized) {
            return;
        }

        if (activity != null) {
            activity.runOnUiThread(() -> {
                try {
                    // Stop animation and frame scheduling
                    if (choreographer != null && frameScheduler != null) {
                        choreographer.removeFrameCallback(frameScheduler);
                    }
                    if (animator != null) {
                        animator.cancel();
                        animator = null;
                    }

                    // Detach surface
                    if (uiHelper != null) {
                        uiHelper.detach();
                    }

                    // Cleanup Filament resources
                    if (engine != null) {
                        if (renderable != 0) {
                            engine.destroyEntity(renderable);
                        }
                        if (renderer != null) {
                            engine.destroyRenderer(renderer);
                        }
                        if (vertexBuffer != null) {
                            engine.destroyVertexBuffer(vertexBuffer);
                        }
                        if (indexBuffer != null) {
                            engine.destroyIndexBuffer(indexBuffer);
                        }
                        if (material != null) {
                            engine.destroyMaterial(material);
                        }
                        if (view != null) {
                            engine.destroyView(view);
                        }
                        if (scene != null) {
                            engine.destroyScene(scene);
                        }
                        if (camera != null) {
                            engine.destroyCameraComponent(camera.getEntity());
                        }

                        EntityManager em = EntityManager.get();
                        if (renderable != 0) {
                            em.destroy(renderable);
                        }
                        if (camera != null) {
                            em.destroy(camera.getEntity());
                        }

                        engine.destroy();
                    }

                    // Remove SurfaceView from parent
                    if (surfaceView != null && surfaceView.getParent() instanceof ViewGroup) {
                        ((ViewGroup) surfaceView.getParent()).removeView(surfaceView);
                    }

                    // Reset state
                    surfaceView = null;
                    uiHelper = null;
                    displayHelper = null;
                    choreographer = null;
                    engine = null;
                    renderer = null;
                    scene = null;
                    view = null;
                    camera = null;
                    material = null;
                    vertexBuffer = null;
                    indexBuffer = null;
                    frameScheduler = null;
                    swapChain = null;
                    renderable = 0;

                    isInitialized = false;
                    currentActivity = null;

                    Log.d(TAG, "Renderer destroyed successfully");
                } catch (Exception e) {
                    Log.e(TAG, "Error destroying renderer", e);
                }
            });
        }
    }

    /**
     * Check if the renderer is currently running.
     *
     * @return true if initialized and running
     */
    public static boolean isRunning() {
        return isInitialized && surfaceView != null;
    }

    // ========== Private setup methods ==========

    private static void setupSurfaceView() {
        uiHelper = new UiHelper(UiHelper.ContextErrorPolicy.DONT_CHECK);
        uiHelper.setRenderCallback(new SurfaceCallback());
        uiHelper.setOpaque(false);
        uiHelper.attachTo(surfaceView);
    }

    private static void setupFilament() {
        engine = Engine.create();
        renderer = engine.createRenderer();
        scene = engine.createScene();
        view = engine.createView();
        camera = engine.createCamera(engine.getEntityManager().create());

        Renderer.ClearOptions options = renderer.getClearOptions();
        options.clear = true;
        renderer.setClearOptions(options);
    }

    private static void setupView() {
        view.setCamera(camera);
        view.setScene(scene);
    }

    private static void setupScene() {
        loadMaterial();
        createMesh();

        renderable = EntityManager.get().create();

        new RenderableManager.Builder(1)
            .boundingBox(new Box(0.0f, 0.0f, 0.0f, 1.0f, 1.0f, 0.01f))
            .geometry(0, RenderableManager.PrimitiveType.TRIANGLES, vertexBuffer, indexBuffer, 0, 3)
            .material(0, material.getDefaultInstance())
            .build(engine, renderable);

        scene.addEntity(renderable);

        startAnimation();
    }

    private static void loadMaterial() {
        //ByteBuffer assetData = readUncompressedAsset("materials/baked_color.filamat");
        //ByteBuffer assetData = readUncompressedAsset("assets/unlit.filamat");
        //ByteBuffer assetData = readUncompressedAsset("unlit.filamat");
        ByteBuffer assetData = readUncompressedAsset("materials/unlit.filamat");
        material = new Material.Builder()
            .payload(assetData, assetData.remaining())
            .build(engine);
    }

    private static void createMesh() {
        final int intSize = 4;
        final int floatSize = 4;
        final int shortSize = 2;
        final int vertexSize = 3 * floatSize + intSize;

        final int vertexCount = 3;
        final double a1 = Math.PI * 2.0 / 3.0;
        final double a2 = Math.PI * 4.0 / 3.0;

        ByteBuffer vertexData = ByteBuffer.allocate(vertexCount * vertexSize)
            .order(ByteOrder.nativeOrder());

        // Vertex 1: Red
        vertexData.putFloat(1.0f)
            .putFloat(0.0f)
            .putFloat(0.0f)
            .putInt(0xffff0000);

        // Vertex 2: Green
        vertexData.putFloat((float) Math.cos(a1))
            .putFloat((float) Math.sin(a1))
            .putFloat(0.0f)
            .putInt(0xff00ff00);

        // Vertex 3: Blue
        vertexData.putFloat((float) Math.cos(a2))
            .putFloat((float) Math.sin(a2))
            .putFloat(0.0f)
            .putInt(0xff0000ff);

        vertexData.flip();

        vertexBuffer = new VertexBuffer.Builder()
            .bufferCount(1)
            .vertexCount(vertexCount)
            .attribute(VertexBuffer.VertexAttribute.POSITION, 0, VertexBuffer.AttributeType.FLOAT3, 0, vertexSize)
            .attribute(VertexBuffer.VertexAttribute.COLOR, 0, VertexBuffer.AttributeType.UBYTE4, 3 * floatSize, vertexSize)
            .normalized(VertexBuffer.VertexAttribute.COLOR)
            .build(engine);

        vertexBuffer.setBufferAt(engine, 0, vertexData);

        ByteBuffer indexData = ByteBuffer.allocate(vertexCount * shortSize)
            .order(ByteOrder.nativeOrder())
            .putShort((short) 0)
            .putShort((short) 1)
            .putShort((short) 2);

        indexData.flip();

        indexBuffer = new IndexBuffer.Builder()
            .indexCount(3)
            .bufferType(IndexBuffer.Builder.IndexType.USHORT)
            .build(engine);

        indexBuffer.setBuffer(engine, indexData);
    }

    private static void startAnimation() {
        animator = new ValueAnimator();
        animator.setFloatValues(0.0f, 360.0f);
        animator.setInterpolator(new LinearInterpolator());
        animator.setDuration(4000);
        animator.setRepeatMode(ValueAnimator.RESTART);
        animator.setRepeatCount(ValueAnimator.INFINITE);

        final float[] transformMatrix = new float[16];

        animator.addUpdateListener(animation -> {
            float rotationDegrees = (float) animation.getAnimatedValue();
            Matrix.setRotateM(transformMatrix, 0, -rotationDegrees, 0.0f, 0.0f, 1.0f);

            TransformManager tcm = engine.getTransformManager();
            tcm.setTransform(tcm.getInstance(renderable), transformMatrix);
        });

        animator.start();
    }


private static ByteBuffer readUncompressedAsset(String assetName) {
    try {
        if (currentActivity == null) {
            throw new IllegalStateException("Activity not available");
        }

        try (InputStream is = currentActivity.getAssets().open(assetName)) {
            byte[] bytes = new byte[is.available()];
            int read = is.read(bytes);
            ByteBuffer dst = ByteBuffer.allocateDirect(read);
            dst.put(bytes);
            dst.rewind();
            return dst;
        }
    } catch (Exception e) {
        Log.e(TAG, "Error reading asset: " + assetName, e);
        throw new RuntimeException("Failed to read asset", e);
    }
}
    // ========== Inner Classes ==========

    /**
     * Frame callback for scheduling rendering frames.
     */
    private static class FrameCallback implements Choreographer.FrameCallback {
        @Override
        public void doFrame(long frameTimeNanos) {
            if (choreographer != null) {
                choreographer.postFrameCallback(this);
            }

            if (uiHelper != null && uiHelper.isReadyToRender() && swapChain != null) {
                if (renderer != null && renderer.beginFrame(swapChain, frameTimeNanos)) {
                    if (view != null) {
                        renderer.render(view);
                    }
                    renderer.endFrame();
                }
            }
        }
    }

    /**
     * Surface callback for managing surface lifecycle.
     */
    private static class SurfaceCallback implements UiHelper.RendererCallback {
        @Override
        public void onNativeWindowChanged(Surface surface) {
            if (swapChain != null && engine != null) {
                engine.destroySwapChain(swapChain);
            }
            if (engine != null && uiHelper != null) {
                swapChain = engine.createSwapChain(surface, uiHelper.getSwapChainFlags());
            }
            if (displayHelper != null && renderer != null && surfaceView != null) {
                displayHelper.attach(renderer, surfaceView.getDisplay());
            }
        }

        @Override
        public void onDetachedFromSurface() {
            if (displayHelper != null) {
                displayHelper.detach();
            }
            if (swapChain != null && engine != null) {
                engine.destroySwapChain(swapChain);
                engine.flushAndWait();
                swapChain = null;
            }
        }

        @Override
        public void onResized(int width, int height) {
            final double zoom = 1.5;
            final double aspect = (double) width / height;
            camera.setProjection(Camera.Projection.ORTHO,
                -aspect * zoom, aspect * zoom, -zoom, zoom, 0.0, 10.0);

            if (view != null) {
                view.setViewport(new Viewport(0, 0, width, height));
            }

            if (engine != null) {
                FilamentHelper.synchronizePendingFrames(engine);
            }
        }
    }

    // Initialize frame scheduler lazily
    private static FrameCallback getFrameScheduler() {
        if (frameScheduler == null) {
            frameScheduler = new FrameCallback();
        }
        return frameScheduler;
    }
}
