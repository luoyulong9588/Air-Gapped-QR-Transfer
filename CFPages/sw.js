const CACHE_NAME = 'airtranslate-v1';

// 预缓存列表（可选，能让加载更快）
const ASSETS = [
    '/',
    '/index.html',
    '/manifest.json'
];

self.addEventListener('install', (e) => {
    e.waitUntil(
        caches.open(CACHE_NAME).then(cache => {
            return cache.addAll(ASSETS);
        })
    );
    self.skipWaiting();
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

// 修复递归问题的 Fetch 策略
self.addEventListener('fetch', (e) => {
    // 1. 只处理 GET 请求
    if (e.request.method !== 'GET') return;

    // 2. 策略：优先尝试网络，失败后回退到缓存
    e.respondWith(
        fetch(e.request)
            .then(response => {
                // 如果请求成功，可以顺便更新缓存（可选）
                return response;
            })
            .catch(() => {
                // 网络不可用时，尝试从缓存中读取
                return caches.match(e.request).then(cachedResponse => {
                    if (cachedResponse) return cachedResponse;
                    // 如果缓存也没有，返回一个错误
                    return new Response('Network error', { status: 408 });
                });
            })
    );
});