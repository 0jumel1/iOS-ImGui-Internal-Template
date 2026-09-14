#include "Menu.h"
#include "imgui.h"

// placeholders, hook these up to your own stuff
static bool esp = false;
static float fov = 90.0f;

void DrawMenu() {
    ImGui::SetNextWindowSize(ImVec2(400, 300), ImGuiCond_FirstUseEver);

    // no close button on purpose, there's no way to get it back once closed.
    // tap the title bar to collapse it instead
    ImGui::Begin("Mod Menu by TheOnno | 0jumel (discord)");

    ImGui::Checkbox("ESP", &esp);
    ImGui::SliderFloat("Aimbot FOV", &fov, 0.0f, 180.0f, "%.0f");

    ImGui::End();
}
