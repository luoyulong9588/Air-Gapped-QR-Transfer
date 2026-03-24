<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>项目文档预览 - Air-Gapped QR Transfer</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.2.0/github-markdown.min.css">
    <style>
        body { background-color: #0d1117; margin: 0; padding: 40px 20px; display: flex; justify-content: center; }
        .markdown-body {
            box-sizing: border-box;
            min-width: 200px;
            max-width: 980px;
            padding: 45px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        @media (max-width: 767px) { .markdown-body { padding: 15px; } }
    </style>
</head>
<body>
    <article class="markdown-body">
        <h1>🚀 Air-Gapped QR Transfer (V4 Pro)</h1>
        <p><strong>基于二维码的断网文件传输系统</strong></p>
        <p>这是一个利用高密度二维码感官通道（Optical Channel）实现物理隔离传输的工具。通过浏览器即可在电脑与手机、或两台手机之间快速传递文件，无需 Wi-Fi、蓝牙或数据线。</p>
        <hr>

        <h2>✨ 核心特性</h2>
        <ul>
            <li><strong>⚡ 极速压缩 (Pako/Zlib)</strong>：集成 <code>pako.js</code> 压缩库。在发送前自动对文件进行 GZIP 级压缩，对于文本、代码等文件可减少 <strong>70% - 90%</strong> 的传输量。</li>
            <li><strong>🛡️ 混合动力容错 (Sequential + Fountain Code)</strong>：
                <ul>
                    <li><strong>顺序模式</strong>：优先按顺序发送分片，让接收端快速建立文件结构。</li>
                    <li><strong>喷泉模式</strong>：在顺序循环后自动切换到卢比变换（LT Codes）逻辑，生成无限的补丁包。接收端只需捕获足够的任意分片即可完成消元解码，无惧摄像头丢帧。</li>
                </ul>
            </li>
            <li><strong>🔄 智能连续传输</strong>：
                <ul>
                    <li><strong>自动重置</strong>：发送端切换文件时，接收端通过 <code>K值校验</code> 自动感知并重置解码器，无需手动刷新页面。</li>
                    <li><strong>内存优化</strong>：自动释放 <code>Blob URL</code>，支持连续传输多个文件而不卡顿。</li>
                </ul>
            </li>
            <li><strong>📱 广角大框扫描</strong>：优化了浏览器的摄像头调用策略，利用 <strong>85% 屏幕面积</strong> 作为有效感官区。</li>
            <li><strong>📄 零乱码保障</strong>：通过元数据精确记录原始文件字节长度，彻底解决由于分片对齐导致的末尾乱码问题。</li>
        </ul>

        <h2>🛠️ 技术栈</h2>
        <ul>
            <li><strong>前端</strong>: HTML5, CSS3, Vanilla JavaScript</li>
            <li><strong>压缩引擎</strong>: Pako.js (Zlib)</li>
            <li><strong>二维码引擎</strong>: QRCode.js (Sender)</li>
            <li><strong>扫描引擎</strong>: Html5-QRCode (Receiver)</li>
        </ul>

        <h2>📖 使用指南</h2>
        <h3>1. 准备环境</h3>
        <p>由于浏览器权限限制，<strong>接收端（扫码端）必须通过 HTTPS 协议访问</strong>（或是本地 localhost）。</p>

        <h3>2. 发送文件 (Sender)</h3>
        <ol>
            <li>打开 <code>hybrid-sender.html</code>。</li>
            <li>点击 <strong>“选择文件”</strong>，系统会自动完成压缩。</li>
            <li>点击 <strong>“开始传输”</strong>，显示循环二维码。</li>
        </ol>

        <h3>3. 接收文件 (Receiver)</h3>
        <ol>
            <li>打开 <code>hybrid-receiver.html</code>。</li>
            <li>允许摄像头权限，将扫描框对准二维码。</li>
            <li>显示 “✅ 解压还原成功” 时，点击 <strong>“保存并解压文件”</strong>。</li>
        </ol>

        <hr>
        <p style="text-align: center; color: #666;">MIT License. 自由修改，尽情传输。</p>
    </article>
</body>
</html>