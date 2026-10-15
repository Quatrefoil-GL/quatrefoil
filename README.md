
Quatrefoil: Three.js in Respo style
----

Docs https://github.com/Quatrefoil-GL/guidebook .

Demo(Chrome with a touch screen) http://r.tiye.me/Quatrefoil-GL/quatrefoil/ .

前端部署使用 COS Action 正式 v1.2.0 的 `public-base-url` 内置校验，不增加重复校验脚本。
PR 的 COS/CDN 路径按编号、run ID、attempt 隔离，Vite base 与上传 prefix 同源；
生产前缀 `Quatrefoil-GL/quatrefoil/` 和原 web-assets rsync 路径保持不变。
上传按事件/分支排队，job/上传分别限制为 15/10 分钟，保留现有类型及 tree-utils 门禁。
Calcit/procs 使用正式 0.29.3，模块依赖使用正式版本，浏览器入口显式配置为 JS。
CI 使用严格 Caps 解析、全量及原有公开命名空间类型检查；开放的动态类型仍需逐步收敛。
0.1.7 候选将 Touch Control 0.0.30、Pointed Prompt 0.0.18 和 Quaternion 0.2.13
组成同一 Calcit 0.29.3 正式依赖图，前两者统一使用正式 js-ffi 0.2.3。
同时去除旧导入语法的冗余 []，不改变导出名称、参数、类型合同或函数实现。
候选发布前须完成原有门禁和下游验证；不代表已经完成 0.30.1 工具链升级。
控制器 CSS 从该 Caps 模块加载，不再另装旧 npm CSS 包。
0.1.6 已在待办新增/编辑/删除、Shapes、Lines、返回和控制器 pointer 路径完成浏览器验收。
修复两字段 `remove-element` 被强行按三字段解构的错误，只为需要 payload 的操作读取第三字段。
未改场景密度；VR、真实多点触控及其余全部场景仍未覆盖。正式发版以 Release 为准。

### Develop

Relies on https://github.com/calcit-lang/calcit .

```bash
caps --strict --ci
yarn install --immutable
calcit calcit.cirru js
yarn vite
```

Caps 维护项目内 `.calcit/modules/` 依赖视图，不手动写入共享模块缓存。

### Credits

GLTF used in the demo: [fantasy-sakura](https://sketchfab.com/3d-models/fantasy-sakura-43f5b135e5af438cb706bbcb5bdf3cf1)

### License

MIT
