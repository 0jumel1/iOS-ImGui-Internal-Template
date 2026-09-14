#import <UIKit/UIKit.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

#import "imgui.h"
#import "imgui_impl_metal.h"
#import "Menu.h"

static id<MTLCommandQueue> queue;
static __weak MTKView *gameView;
static bool ready = false;

static void setupImGui(id<MTLDevice> device) {
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGui::GetIO().IniFilename = NULL; // don't write imgui.ini into the app
    ImGui::StyleColorsDark();
    ImGui_ImplMetal_Init(device);
}

%hook MTKView

- (void)drawRect:(CGRect)rect {
    %orig;

    // some games have more than one MTKView, only draw on the first one
    if (!self.device || (gameView && gameView != self))
        return;

    if (!ready) {
        queue = [self.device newCommandQueue];
        setupImGui(self.device);
        ready = true;
    }
    gameView = self;

    MTLRenderPassDescriptor *pass = [self.currentRenderPassDescriptor copy];
    if (!pass)
        return;
    // default is clear, which wipes the game frame
    pass.colorAttachments[0].loadAction = MTLLoadActionLoad;

    ImGuiIO &io = ImGui::GetIO();
    io.DisplaySize = ImVec2(self.bounds.size.width, self.bounds.size.height);
    io.DisplayFramebufferScale = ImVec2(self.contentScaleFactor, self.contentScaleFactor);

    id<MTLCommandBuffer> cmd = [queue commandBuffer];
    id<MTLRenderCommandEncoder> enc = [cmd renderCommandEncoderWithDescriptor:pass];

    ImGui_ImplMetal_NewFrame(pass);
    ImGui::NewFrame();
    DrawMenu();
    ImGui::Render();
    ImGui_ImplMetal_RenderDrawData(ImGui::GetDrawData(), cmd, enc);

    [enc endEncoding];
    [cmd commit];
}

%end

%hook UIWindow

- (void)sendEvent:(UIEvent *)event {
    UITouch *touch = [event.allTouches anyObject];

    if (ready && gameView && touch && event.type == UIEventTypeTouches) {
        ImGuiIO &io = ImGui::GetIO();
        CGPoint p = [touch locationInView:gameView];
        io.AddMousePosEvent(p.x, p.y);

        if (touch.phase == UITouchPhaseBegan)
            io.AddMouseButtonEvent(0, true);
        else if (touch.phase == UITouchPhaseEnded || touch.phase == UITouchPhaseCancelled)
            io.AddMouseButtonEvent(0, false);
    }

    // TODO: eat touches that land on the menu so the game doesn't get them too
    %orig;
}

%end

%ctor {
    NSLog(@"[ImGuiMetalTweak] loaded");
}
