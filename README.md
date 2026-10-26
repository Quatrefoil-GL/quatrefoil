
Quatrefoil: Three.js in Respo style
----

Docs https://github.com/Quatrefoil-GL/guidebook .

Demo(Chrome with a touch screen) http://r.tiye.me/Quatrefoil-GL/quatrefoil/ .

前端部署使用 COS Action 正式 v1.2.0 的 `public-base-url` 内置校验，不增加重复校验脚本。
PR 的 COS/CDN 路径按编号、run ID、attempt 隔离，Vite base 与上传 prefix 同源；
生产前缀 `Quatrefoil-GL/quatrefoil/` 和原 web-assets rsync 路径保持不变。
上传按事件/分支排队，job/上传分别限制为 15/10 分钟，保留现有类型及 tree-utils 门禁。
使用者影响：当前 main 声明为候选 0.2.0-alpha.1，配对 Calcit/procs 0.31.0-alpha.6；
它不是正式 0.30.1 的纯依赖更新，也不代表该候选已发版。strict Caps 消费者需同步
工具链和依赖图；留在正式 0.30.1 的项目应继续核对对应正式 tag，不直接追随 main。
已发布正式版为 0.1.10，旧 tag 保留原内容。浏览器入口仍为 JS。
本轮已合并 #75 改动坐标遍历：find-element、reach-object3d 在原 empty? 判断之后，
只继续遍历 List，否则抛出明确错误；`empty?` 判空分支仍先执行，不能理解成所有非 List 都抛错。
=seq? 保留原 `empty?` 判空分支，仅在双方为 List 时继续比较头部并递归。
无内部调用的 =component? 已删除；外部若引用该 helper，需自行审阅并迁移，不能据此承诺公开 API 完全兼容。
CI 使用严格 Caps 解析、全量及原有公开命名空间类型检查；开放的动态类型仍需逐步收敛。
当前模块依赖仍为正式 Touch Control 0.0.32、Pointed Prompt 0.0.20 和 Quaternion 0.2.16。
此前 0.1.10 的正式 0.30.1 配对说明不适用于当前 alpha 工具链；本轮 Snapshot 确有上述源码修改，
并非“无 alpha、源码不变”。没有以非 strict 或忽略警告绕过原门禁。
Pointed Prompt 0.0.20 会更早拒绝非法 textarea? 值；本项目原有调用仅提供 initial，不传该选项。

以下是此前 0.1.9（已发布）相对 0.1.8 的迁移背景，不是本轮新增的执行代码改动：
55 处旧 Option helper 改为已知接收者方法或开放 payload 的显式 match；
缺失值、已有 nil、false、0、空字符串和原默认值保持原有区别，不新增强转或通用兼容层。
GLTF 缓存收紧为 `Ref<Map<Tag, JsObject>>`；加载结果经过既有外部 GltfHost 的受检转换，
不再使用两处 unsafe 强转。非法查询 key 仍走原有未加载提示，不改成强制解码抛错。
导出名称、位置/控制器算法、场景密度与生产路径不变；类型债务仍需继续收敛。
正式 0.1.9 已包含此前合并的 #65 Option 清理，不能把相对 0.1.8 的整个 release 称为纯元数据变化：
update-states 缺少第二 payload 现在抛错，已有显式 nil payload 仍存为真实 nil。
arrange-children 和待办项读取保留 Option；原 CI 中增加一组直接运行的精简语义回归，
覆盖空 children、单个 nil/false/0/空字符串及显式 nil state，不新增脚本文件。
内部 select-keys 的 foldl 参数顺序仍有既存错误，已报告 #69；唯一引用位于已注释的
旧 diff 逻辑，当前不执行，不恢复该旧路径，也不把它误认为活动渲染问题的根因。
后续候选发布前仍须完成原有门禁及相应消费者验收；既有 #64 开关后受光几何
可见性问题尚未确认解决，不能用普通 CI 或本依赖更新冒称修复。
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
