
Quatrefoil: Three.js in Respo style
----

Docs https://github.com/Quatrefoil-GL/guidebook .

Demo(Chrome with a touch screen) http://r.tiye.me/Quatrefoil-GL/quatrefoil/ .

前端部署使用 COS Action 正式 v1.2.0 的 `public-base-url` 内置校验，不增加重复校验脚本。
PR 的 COS/CDN 路径按编号、run ID、attempt 隔离，Vite base 与上传 prefix 同源；
生产前缀 `Quatrefoil-GL/quatrefoil/` 和原 web-assets rsync 路径保持不变。
上传按事件/分支排队，job/上传分别限制为 15/10 分钟，保留现有类型及 tree-utils 门禁。
使用者影响：候选 0.1.8 配对正式 Calcit/procs 0.30.0；strict Caps 消费者需同步工具链和模块依赖，旧 tag 保留原内容。浏览器入口仍为 JS。
CI 使用严格 Caps 解析、全量及原有公开命名空间类型检查；开放的动态类型仍需逐步收敛。
本候选将已发布的 Touch Control 0.0.31、Pointed Prompt 0.0.19 和 Quaternion 0.2.14
组成同一 Calcit 0.30.0 正式依赖图，前两者仍统一使用正式 js-ffi 0.2.3。
55 处旧 Option helper 改为已知接收者方法或开放 payload 的显式 match；
缺失值、已有 nil、false、0、空字符串和原默认值保持原有区别，不新增强转或通用兼容层。
GLTF 缓存收紧为 `Ref<Map<Tag, JsObject>>`；加载结果经过既有外部 GltfHost 的受检转换，
不再使用两处 unsafe 强转。非法查询 key 仍走原有未加载提示，不改成强制解码抛错。
导出名称、位置/控制器算法、场景密度与生产路径不变；类型债务仍需继续收敛。
候选发布前须完成原有门禁和独立下游验证；尚未发布的 0.30.1 不算本轮已验收。
升级 procs 后重启旧 Vite 开发服务，必要时使用 `yarn vite --force` 重建预构建缓存。
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
