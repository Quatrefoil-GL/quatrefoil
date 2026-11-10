# Quatrefoil

## 0.3.6 候选 / Calcit 0.40.0

升级后请配套使用正式 Calcit 与 `@calcit/procs` 0.40.0，以及 Quaternion 0.2.25。重新安装依赖并生成 JS。直接构造场景补丁时，新增节点使用 `RenderTree`，替换节点使用清理后的 `Shape` 或空值。
`Shape` 的位置与缩放仍接受四元数库的 `V3` 或数字列表，旋转接受数字列表。
省略或传入 nil 时沿用 Three.js 默认变换。错误的变换值会在构造形状时提前报错。
形状名使用 Tag，组件名和子节点合同沿用原接口。

需要给应用事件做类型检查时，可以把渲染调用改为
`render-canvas-with-dispatch! markup read-state read-action on-event!`。
`markup` 接受 `Component | Shape`。提供 `read-state(raw)` 和
`read-action(tag, raw)` 解码器后，`on-event!` 收到
`DispatchEvent<S, A>`，可分别匹配 `(:states cursor value)` 和 `(:action action)`。
现有 `render-canvas!` 调用可继续使用。

新入口把 `d! cursor data` 和 `d! :states ([] cursor data)` 统一为同一种状态事件。
游标必须由 Tag 组成，状态 pair 必须有第二项。应用解码器决定是否接收该项的 nil，
以及接受哪些操作和数据。操作名、游标或数据解码失败时，事件不会送到 `on-event!`。

## 0.3.4 候选：Calcit 0.37.0

配对正式 Calcit CLI / `@calcit/procs` **0.37.0**、Touch Control 0.0.39、Pointed Prompt 0.0.27、Quaternion 0.2.23，传递 JS-FFI 保持 0.2.13。`edit format` 把 rest 类型改为 `(& T)` 写法；`JsArrayHost.filter` 的旧记录式 Fn 签名改为同义的 `Fn` 写法，回调仍为 `JsObject Number JsArrayHost -> Bool`。渲染与公开合同不变。仍在 0.35.1 的消费者保留 0.3.3。

## 历史 0.3.3 候选

使用 Calcit CLI / `@calcit/procs` 0.35.1、Touch Control 0.0.38、Pointed Prompt 0.0.26、Quaternion 0.2.22 及传递依赖 JS-FFI 0.2.13。升级时重新安装精确依赖图并生成 JS。

`ShapePathCommand` 提供移动、直线、二次曲线和三次曲线的名义类型与数值参数。内置 Shapes 和 Mirror 用它构造路径，渲染入口继续接受已有的匿名路径元组。

## 0.3.2 依赖配对候选

使用者影响：继续配对正式 Calcit / @calcit/procs **0.34.2**，改用正式 Touch Control
**0.0.37**、Pointed Prompt **0.0.25**、Quaternion **0.2.20**，传递 JS-FFI **0.2.10**。
消费者需要协调完整模块图后重新生成 JS；不要与 JS-FFI 0.2.9 混装，不移动 0.3.1 旧 tag。

本次 Snapshot 与 0.3.1 字节一致，没有改变渲染公式、相机、状态/事件、HUD 或公开类型。
Three 和其他 npm 依赖保持。正式 Caps strict/toolchain、immutable、全定义 366/366、
公开定义 278/278、完整 strict（diagnostics=[]）、原两项 Vec3、Option 断言、tree-utils
独立 immutable 与构建通过；unresolved 137、unsafe 32，原预算不放宽，
deprecated-call / dynamic-method 均为零。

全新临时 Chrome 156 headless profile 实际启动 WebGL 和控制器，hslx 三原色返回值正确；
通过公开 dispatch 切换 Portal、Demo、Lines、Shapes、Shader、Control 六个场景，
Three geometry 坐标均有限，并能刷新启动。程序化派发不是鼠标 raycast 命中或视觉保真验收；
实体移动设备、VR 和跨 GPU 行为未在本轮复验。新精确 CI 和下游正式安装仍需跟进。
0.3.2 在正式 Git tag 创建前为候选，不发布 npm，不合并或部署下游业务应用。

## 0.3.1 使用者需要注意

`hslx(h,s,l)` 继续接收角度/百分比并使用原 Three.Color 取色算法，现在公开返回 Number。
消费者可直接把结果用于数值颜色，不再需要为 hslx 重复检查 Number；仍需保留其他真实
宿主/状态入口的检查。CLI/procs 与全部模块依赖保持 0.34.2 / 原正式图，Three 版本不变。

仅 hslx 的 code/schema/doc 改变：以 js-cast 检查 Color 能力，在同一接收者调用 setHSL，
再检查 getHex 数值结果。保留 JS FFI 标记，删除该函数两处 unsafe，不把 setHSL 返回值
当作已经证明的宿主。整个库的 unsafe 34→32、schema Dynamic 357→356，unresolved
仍为 137，原上限和原检查不变；没有新增脚本、测试框架、排除或编译器改写规则。

全部 366 定义、公开 278 定义、完整 strict、原两项 Vec3 回归、原 Option 断言、
严格 Caps/工具链、immutable、tree-utils 独立锁及构建通过。真实 Three 0.168 的七组
颜色与 0.3.0 原实现一致。Grid 用本地 0.3.1 候选源码去掉三处冗余颜色解码后，
全部定义/完整 strict/构建和实际 Three 0.166 的五个场景摘要与正式 0.3.0 基线一致，
坐标有限。这是明确的候选消费者预检，不是尚未发布 tag 的正式安装验收。

临时 Vite 内存检查只用 div/键盘监听占位初始化模块；WebSocket 绑定限制保留，
不当作 DOM 交互、WebGL、VR 或跨 GPU 验收。此补丁处理 [#66](https://github.com/Quatrefoil-GL/quatrefoil/issues/66)，
不改变 #67 的控件合同或 #86 的 parametric Option 合同。

## 0.3.0 已发布合同

正式 **0.3.0** 配对正式 Calcit CLI / `@calcit/procs` **0.34.2**，消费者须同步完整精确依赖图并重新生成 JS。已发布 0.2.0 的历史 tag 保持。

`:position` / `:scale` 接受 Quaternion V3 或恰好三个 Number 的 List。当前 main 已加入的 `Vec3Value` union 保持；本轮补足长度检查，空、两项、四项列表会在写入 Three 对象前明确报错，合法向量与原缩放处理保持。公开辅助函数 `read-vec3` 现在返回 `Tuple Number Number Number`，使用 `let[]` 读取三个位置；不要再将 Tuple 的位置读取当作 Option 解包。本轮包含合同收紧，因此使用新 minor 0.3.0。

Map.to-list 已保留异构键值 Tuple；Todo 与构建树改用 `let[]`，不再把键和值当作同质 List 或把真实字段当成 Option。Number key、顺序和内容保持。原场景、Three.js 依赖范围、控制器、HUD 与部署路径保持。

完整正式依赖图为 Touch Control **0.0.36**、Pointed Prompt **0.0.24**、Quaternion **0.2.19**，传递 JS-FFI **0.2.9**。已从正式 tags 完成 Caps strict/toolchain 安装，不用 main/hash 或本地候选替代依赖。0.3.0 已发布正式 Git tag，不发布 npm。

本库是 Three.js 的 Calcit JS 包装与 Demo，不承诺 native/WASM 渲染。

- [文档](https://github.com/Quatrefoil-GL/guidebook)
- [Demo](https://r.tiye.me/Quatrefoil-GL/quatrefoil/)

## 验证与边界

本地全部 **366** 定义（含依赖）、**278** 个项目公开定义及完整 strict（diagnostics=[]）通过。原 Option 的 nil/false/0/空字符串、显式 nil 状态存储断言保持；未解决类型总量 **137**，原上限不放宽，dynamic-method/deprecated 为零。开放宿主与场景数据仍存在，不宣称 Dynamic 清零。

`read-vec3` 的两项附带回归覆盖两种合法表示和错误长度，复用原 CI 验证步骤，不新增脚本或框架。原构建及 tree-utils 独立 immutable 安装通过。生成 JS 已通过 Vite 内存 SSR 的向量正反例、真实 Three.Object3D 的位置/缩放、键控对象树及合成 Todo 检查；不创建 WebGL 上下文，不是实际浏览器视觉/交互验收。

官方 Node 回放器的 JS 预加载目前被已发布 `@quatrefoil/utils` 的扩展名导入阻塞；没有新增排除或将它记为通过。上述打包辅助的内存检查与 Node 直接模块加载是不同范围。

正式 0.34.2 尚不支持将 Tuple 直接作为受检解码目标，见 [Calcit #2557](https://github.com/calcit-lang/calcit/issues/2557)。因此保留 V3 / List Number 的表示 union，由 `read-vec3` 检查准确长度并重建三项 Tuple；该 union 本身不证明长度。方法查询将 Tuple 的 Add 标成 proven，但实际 strict 正确拒绝，见 [Calcit #2558](https://github.com/calcit-lang/calcit/issues/2558)，本轮不依赖这条误导提示或放宽门禁。

## 开发

使用 Node.js 24、Yarn 4.18.0、Caps 0.1.1 和 Calcit 0.34.2：

```bash
caps --strict --ci
yarn install --immutable
caps verify --toolchain
yarn dev
```

`yarn dev` 先生成 JS 并复制原 assets，再启动 Vite；`yarn release` 执行相同资源准备与生产构建。源码修改后需重新编译；必要时用 `yarn vite --force` 重建旧预构建缓存。`js-out/`、`dist/` 与 `.calcit/` 不提交。

Snapshot 只通过官方 query/tree/edit 读取和修改，先读 `calcit docs agents --contract`。原全定义、24 个公开命名空间、完整 strict、未解析弱类型上限和 Option 断言保持；tree-utils 保留独立 immutable 安装。

## 从旧版升级

当前 main 还已包含此前的字段/Option 清理，本轮不恢复旧路径：

- `find-element`、`reach-object3d` 在原 empty? 判断后只继续遍历 List；`=seq?` 保留原判空顺序。
- `=component?` helper 已删除，旧调用者须迁移；update-states 缺少第二 payload 仍报错，显式 nil payload 仍保留。
- GLTF 缓存保持 `Ref<Map<Tag,JsObject>>` 和 GltfHost 检查，非法 key 仍走未加载提示。
- Pointed Prompt 对非法 textarea? 值的拒绝保持；Demo 只提供 initial。

## 部署与已知限制

COS 只上传前端 dist，使用 action 内置 verify，PR 前缀包含编号/run/attempt；Vite base、生产前缀和原 web-assets 路径保持。仅创建 PR 和隔离预览，合并/正式发版另按验收决定。

[几何切换可见性 #64](https://github.com/Quatrefoil-GL/quatrefoil/issues/64) 尚未确认解决，不能用类型/CI 通过冒称修复。内部 select-keys 的 foldl 顺序问题由 [#69](https://github.com/Quatrefoil-GL/quatrefoil/issues/69) 跟踪，唯一引用在注释旧 diff 逻辑中，本次不恢复旧路径或擅自删除可能被外部引用的 helper。VR、多点触控和所有场景组合未完整验收。

Actions 保持精确正式 tag，npm 保持统一 60 分钟包龄，无包级豁免。

## Credits

Demo GLTF: [fantasy-sakura](https://sketchfab.com/3d-models/fantasy-sakura-43f5b135e5af438cb706bbcb5bdf3cf1)。

## License

MIT
