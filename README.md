# Quatrefoil

使用者注意：本候选 **0.2.0（尚未发布）** 将当前 main 的 Calcit/procs **0.31.0** 同步到正式 **0.32.1**，调用方须同步安装工具链与精确依赖图、重新生成 JS 并重启旧 Vite 服务。本轮仅转换旧类型表示，280 个定义的完整官方视图与规范化 main 等价；不改变渲染算法、场景密度或公开类型。

本库是 Three.js 的 Calcit JS 包装与 Demo，源码和浏览器入口以 `calcit.cirru` 为准，版本以 `deps.cirru` 为准；不承诺 native/WASM 渲染。当前已发布正式版 `0.1.10` 配对 `0.30.1`，历史 tag 不移动。`0.2.0` 包含 main 先前的 API 变更，不能作为 `0.1.10` 的纯元数据 patch 使用。

- [文档](https://github.com/Quatrefoil-GL/guidebook)
- [Demo](https://r.tiye.me/Quatrefoil-GL/quatrefoil/)

## 开发与验证

精确已发布依赖为 Touch Control `0.0.35`、Pointed Prompt `0.0.24`、Quaternion `0.2.19`，传递 JS-FFI `0.2.9`；不以本地候选或 hash 替代版本。保留原 Three.js 依赖范围，控制器 CSS 来自 Caps 模块。

使用 Node.js 24、Yarn 4.18.0 和 Calcit 0.32.1：

```bash
caps --strict --ci
yarn install --immutable
caps verify --toolchain
yarn dev
```

`yarn dev` 先生成 JS 并复制原 assets，再启动 Vite；`yarn release` 执行相同资源准备与生产构建。Calcit 源码修改后需重新编译；必要时用 `yarn vite --force` 重建旧预构建缓存。`js-out/`、`dist/` 与 `.calcit/` 不提交。

修改 Snapshot 前读取 `calcit docs agents --contract`，通过官方 `query`、`tree`、`edit` 读取和修改，不能按文本处理 Snapshot。原全定义、24 个公开命名空间、完整 strict、未解析弱类型上限和 Option 语义断言保留；tree-utils 继续独立 immutable 安装。不关闭默认审计、不扩大预算，不声称现有动态/unsafe 债务清零。

## 从旧正式版升级

以下是当前 main 已包含的变更，本轮不再重复修改其执行逻辑：

- `find-element`、`reach-object3d` 在原 `empty?` 判断之后只继续遍历 List；`=seq?` 同样保留原判空分支，仅在双方为 List 时递归。不能理解成所有非 List 均直接抛错。
- `=component?` helper 已删除；外部引用者须迁移。`update-states` 缺少第二 payload 会报错，已有显式 nil payload 仍存为真实 nil；nil/false/0/空字符串的 children 原语义继续由原断言保护。
- GLTF 缓存已收紧为 `Ref<Map<Tag,JsObject>>`，加载结果经既有 GltfHost 受检转换。非法查询 key 仍走未加载提示，不改为强制解码抛错。
- Pointed Prompt 会更早拒绝非法 `textarea?` 值；本 Demo 只提供 initial，不传该选项。`remove-element` 仍只为需要 payload 的操作读取第三字段。

## 部署与已知限制

前端 COS 仅使用 `cos-upload-action` 的内置 `public-base-url` 校验。PR 的 prefix 按编号/run/attempt 隔离，Vite base 同源；生产前缀 `Quatrefoil-GL/quatrefoil/` 和原 web-assets rsync 路径保持。合并与生产部署单独决定，本轮不触发。

Actions 使用精确正式 tag，维护者已接受 tag 可移动风险；只读权限与关闭 checkout 凭据持久化保持，不把它们描述为不可变保障。npm 统一 60 分钟包龄，无包级豁免。

[几何切换可见性 #64](https://github.com/Quatrefoil-GL/quatrefoil/issues/64) 尚未确认解决，不能用类型/CI 通过冒称已修复。内部 `select-keys` 的 foldl 顺序错误继续由 [#69](https://github.com/Quatrefoil-GL/quatrefoil/issues/69) 跟踪；其唯一引用在注释旧 diff 逻辑中，本次不恢复旧路径或擅自删除可能被外部引用的 helper。VR、真实多点触控及所有场景组合未完整验收。

## Credits

Demo GLTF: [fantasy-sakura](https://sketchfab.com/3d-models/fantasy-sakura-43f5b135e5af438cb706bbcb5bdf3cf1)。

## License

MIT
