# 🔧 VCRUNTIME140.DLL — Automated Fix

> **One-click fix** for the infamous `VCRUNTIME140.DLL is missing` error on Windows 10 & 11.

![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?logo=windows&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-x86%20%7C%20x64-green)
![License](https://img.shields.io/badge/License-Free-brightgreen)
![Admin](https://img.shields.io/badge/Requires-Administrator-orange)

---

## 📋 What Is This?

A lightweight Windows batch script that **automatically downloads and installs** the correct Microsoft Visual C++ Redistributable to fix the `VCRUNTIME140.DLL is missing` error — no manual searching, no confusing downloads.

### The Problem

Many applications and games fail to launch with an error like:

```
The program can't start because VCRUNTIME140.dll is missing from your computer.
Try reinstalling the program to fix this problem.
```

This happens when the **Microsoft Visual C++ 2015–2022 Redistributable** is not installed on your system.

### The Solution

This script handles everything for you:

1. ✅ Automatically requests Administrator permissions
2. ✅ Detects your system architecture (32-bit or 64-bit)
3. ✅ Downloads the correct installer(s) directly from Microsoft
4. ✅ Installs silently in the background
5. ✅ Verifies the DLL is successfully installed
6. ✅ Cleans up temporary files

---

## 🚀 How to Use

1. **Download** the `VCRUNTIME140.DLL AUTOMATED FIX.bat` file
2. **Double-click** to run it
3. **Click "Yes"** when Windows asks for Administrator permission
4. **Wait** for the script to finish (usually under a minute)
5. **Restart** your computer if prompted

That's it! 🎉

---

## 🖥️ System Requirements

| Requirement        | Details                          |
|--------------------|----------------------------------|
| **OS**             | Windows 10 / Windows 11         |
| **Architecture**   | x86 (32-bit) or x64 (64-bit)    |
| **Internet**       | Required (to download installer) |
| **Permissions**    | Administrator                    |
| **PowerShell**     | 5.0+ (included with Windows)    |

---

## ⚙️ How It Works

```
┌────────────────────────┐
│  Run the .bat file     │
└──────────┬─────────────┘
           ▼
┌────────────────────────┐
│  Check for Admin       │──── No ──▶ Request elevation via UAC
│  privileges            │            and relaunch as Admin
└──────────┬─────────────┘
           ▼
┌────────────────────────┐
│  Detect architecture   │──── Checks PROCESSOR_ARCHITECTURE
│  (x86 or x64)         │     environment variable
└──────────┬─────────────┘
           ▼
┌────────────────────────┐
│  Download VC++ Redist  │──── Always downloads x86
│  from Microsoft        │     + x64 if on 64-bit OS
└──────────┬─────────────┘
           ▼
┌────────────────────────┐
│  Silent install        │──── /install /quiet /norestart
└──────────┬─────────────┘
           ▼
┌────────────────────────┐
│  Verify DLL exists in  │──── Checks System32 & SysWOW64
│  system directories    │
└──────────┬─────────────┘
           ▼
┌────────────────────────┐
│  Cleanup temp files    │──── Deletes downloaded installers
│  & report result       │
└────────────────────────┘
```

---

## 🔒 Is It Safe?

**Yes.** This script:

- Downloads **only** from official Microsoft URLs (`https://aka.ms/vs/17/release/...`)
- Installs the same redistributable you'd get from [Microsoft's official page](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist)
- Contains **no third-party DLLs** — it lets the Microsoft installer handle everything
- Cleans up after itself — no leftover files
- Source code is fully readable (it's a `.bat` file — open it in any text editor)

---

## ❓ FAQ

<details>
<summary><b>My antivirus flagged the script — is it a virus?</b></summary>

No. Some antivirus programs flag `.bat` files that request admin permissions or download files from the internet. This is a false positive. You can review the full source code yourself — it's a plain-text batch file.

</details>

<details>
<summary><b>The error still appears after running the fix</b></summary>

Try these steps:
1. **Restart your computer** — some installs require a reboot
2. **Reinstall the application** that was giving the error
3. If the issue persists, download the installer manually from [Microsoft](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist)

</details>

<details>
<summary><b>Does this fix MSVCP140.dll too?</b></summary>

**Yes!** The Visual C++ Redistributable package includes both `vcruntime140.dll` and `msvcp140.dll`, along with other related runtime libraries.

</details>

<details>
<summary><b>Can I run this on Windows 7 / 8?</b></summary>

This script is designed and tested for **Windows 10 and Windows 11** only. It may work on older Windows versions but is not officially supported.

</details>

---

## 🎬 Created By

**404 Brain Found**

[![YouTube](https://img.shields.io/badge/YouTube-Subscribe-red?logo=youtube&logoColor=white)]([https://www.youtube.com/@404BrainFound-T](https://youtu.be/F5qCSGerdco))

If this tool helped you, consider **liking** the video and **subscribing** to the channel! 🙏

---

## 📄 License

This project is free to use and distribute. If you share it, please credit **404 Brain Found**.

---

<p align="center">
  <i>Made with ❤️ to save you from DLL hell</i>
</p>
