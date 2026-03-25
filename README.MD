# 🚀 Air-Gapped QR Transfer (V4 Pro) —— 极速二维码断网传输系统

这是一个利用高密度二维码感官通道（Optical Channel）实现物理隔离传输的工具。它与 [BlueKey-Trans](https://github.com/luoyulong9588/BlueKey-Trans) 配合使用，解决了内网环境下的双向文件交换难题。

---

## ✨ 核心特性
* **⚡ 极速压缩 (Pako/Zlib)**：文本、代码等文件传输量减少 **70% - 90%**。
* **🛡️ 混合动力容错 (Sequential + Fountain Code)**：
    * **顺序模式**：快速建立文件结构。
    * **喷泉模式**：循环生成卢比变换（LT Codes）无限补丁包，无惧摄像头丢帧。
* **🔄 智能感应**：自动感知文件切换并重置解码器，支持连续传输多个文件。
* **📱 广角大框扫描**：优化摄像头策略，利用 85% 屏幕面积作为感效区。

## 🛠️ 技术栈
* **压缩引擎**: [Pako.js](https://github.com/nodeca/pako) (Zlib)
* **核心库**: QRCode.js (生成) / Html5-QRCode (识别)
* **协议**: 顺序循环 + 喷泉码冗余算法。

## 🔗 联动方案 (内网生存指南)
本工具主要用于**从隔离电脑中传出文件**。若需**向隔离电脑传入数据**，由于电脑无法反向扫码，建议配合使用基于硬件模拟技术的：
👉 [**Luo-Link: BlueKey-Trans (蓝牙物理键传)**](https://github.com/luoyulong9588/BlueKey-Trans)

## 📖 使用简述
1.  **发送端 (Sender)**：电脑端打开页面，选择文件并开始显示循环二维码。
2.  **接收端 (Receiver)**：手机端打开 HTTPS 页面，对准屏幕扫码，进度条完成后点击保存。

## 📜 许可协议
MIT License. 由 **(Yulong)** 开发。