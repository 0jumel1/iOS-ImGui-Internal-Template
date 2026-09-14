<div align="center">
  <h1>iOS-ImGui-Internal-Template</h1>
  <p><strong>A Boilerplate for Injecting Modern Dear ImGui Menus into iOS Games via Metal API</strong></p>
  <p>Developed by <b>ONNO</b></p>
</div>

---

## Prerequisites

Before you begin, ensure you have the following installed and configured:

1. **[Theos](https://github.com/theos/theos)**: The cross-platform build system for iOS tweaks.
2. **iOS SDK**: Ensure you have a valid SDK assigned to your `TARGET` variable in the `Makefile`.
3. **macOS / Linux / Windows (WSL)** environment correctly set up with Theos.
4. Build the `.deb` by running `make package`. Output will be in the `packages` folder.
<img width="866" height="444" alt="16" src="https://github.com/user-attachments/assets/d4d30d62-9727-4d9c-bf64-1f8ba5cb784b" />

## Injection & Usage

### For Non-Jailbroken Devices (Sideloading)
1. Obtain the decrypted `.ipa` file of your target game.
2. Use a tool like **Sideloadly** or **Azule**.
3. Inject the compiled `.deb` into the `.ipa` and install it onto your device.

## Developer

- **ONNO** (@0jumel)

> *If you have questions or need assistance, feel free to reach out via Discord!*

## License

This project is provided as an educational boilerplate. It incorporates parts of Dear ImGui, which is licensed under the MIT License. Please provide appropriate credit if you use this boilerplate as a base for your own releases!
</content>
</invoke>
