const CACHE_NAME = 'airtranslate-v2'; // 升级版本号以清除旧缓存

// 建议只缓存核心文件，确保这些路径在浏览器里能直接打开
const ASSETS = [
    './receiver.html',
    './manifest.json'
];

self.addEventListener('install', (e) => {
    // 使用 skipWaiting 让新版本立即接管
    self.skipWaiting();
    e.waitUntil(
        caches.open(CACHE_NAME).then(cache => {
            // 使用 map 逐个添加，防止其中一个 404 导致全部失败
            return Promise.allSettled(
                ASSETS.map(url => cache.add(url))
            );
        })
    );
});

self.addEventListener('activate', (e) => {
    e.waitUntil(
        caches.keys().then(keys => {
            return Promise.all(keys.map(key => {
                if (key !== CACHE_NAME) return caches.delete(key);
            }));
        })
    );
    return self.clients.claim();
});

// 改进的 Fetch 策略：网络优先，报错则回退缓存
self.addEventListener('fetch', (e) => {
    if (e.request.method !== 'GET') return;

    // 排除掉外部 CDN 链接，避免 CORS 导致的安装挂起
    if (!e.request.url.startsWith(self.location.origin)) return;

    e.respondWith(
        fetch(e.request)
            .then(response => {
                // 只有有效的响应才存入缓存
                if (response && response.status === 200 && response.type === 'basic') {
                    const responseToCache = response.clone();
                    caches.open(CACHE_NAME).then(cache => {
                        cache.put(e.request, responseToCache);
                    });
                }
                return response;
            })
            .catch(() => {
                return caches.match(e.request);
            })
    );
});