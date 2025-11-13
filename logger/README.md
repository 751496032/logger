## 介绍

Logger是一款简单、漂亮、实用的鸿蒙应用日志框架，是基于鸿蒙系统提供的hiLog日志库封装的，主要特性：

- 支持堆栈信息输出；
- 支持众多数据格式输出，如基本数据类型、对象、Map、List、JSON等格式，可以一次性打印多个数据格式的数据；
- 支持自定义TAG；
- 支持在日志定位跳转到源码；
- 支持自定义日志行为，比如日志上报、缓存本地等。

日志在控制台的打印效果，如下：

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/f07550fbabfb4e07a7438041e47ec4d9.png)


## 安装

```
ohpm install @hzw/logger
```

或者安装本地包

```
ohpm install ../libs/logger.har
```

## 使用

### 初始化

默认情况下是不需要手动初始化的，直接通过Logger类调用不同level的函数打印日志，如下：

```
const map = new Map<string, Object>()
map.set('name', 'HZWei')
map.set('age', '18')
map.set('user', new UserInfo('HZWei', 20))
Logger.f(map)
```

**但还是建议你通过Logger的init()方法进行初始化配置，默认配置在release环境是不会关闭日志输出的。**

可根据你自身需求来初始化配置信息，如下：

```
Logger.init({
  domain: 0x6666,
  showStack: true,
  fullStack: false,
  showDivider: true,
  debug:true,
  tag: 'xml'
  cacheLineNum: 50,
} as LogConfig)
```

配置参数：

- domain: 作用域，是一个十六进制整数，范围从0x0到0xffff
- tag：日志标记，默认是Logger
- debug：控制是否打印日志，为true时会输出日志，反之则不会
- fullStack：是否输出全部堆栈信息，建议设为false，日志会更简洁
- showStack：是否显示堆栈信息
- showDivider：是否显示分割线
- cacheLineNum：针对行数较多的日志，建议采用「分批循环输出」策略——每次输出指定行数，避免一次性打印全部内容导致截断/不全。例如设置每批输出50行，对于长日志，则会按「每50行一批」的节奏持续输出，直至所有内容打印完毕。

```
export interface LogConfig {
  readonly domain: number 
  readonly tag?: string
  readonly debug: boolean
  readonly  fullStack?: boolean
  readonly showStack?: boolean
  readonly showDivider?: boolean,
}
```

### 打印各种数据格式

```
// 基本数据类型
const msg = 'Hello World';
const msg2 = 'Hello Logger';
Logger.i(msg)

// 数组
const messages = [msg, msg2]
Logger.d(messages)

// 多个数据格式一起打印
const user = new UserInfo('HZWei', 18)
Logger.w(user)
Logger.e(user, messages, 12, true)

// json
Logger.json(user)

// map
const map = new Map<string, Object>()
map.set('name', 'HZWei')
map.set('age', '18')
map.set('user', new UserInfo('HZWei', 20))
Logger.f(map)

// ArrayList
const list = new ArrayList<string>()
list.add('HZWei')
list.add('XML')
Logger.w(list)

// 自定义tag
Logger.wt('hzw',20)
```

### 自定义日志行为

目前Logger只支持在控制台打印，如果你需要将日志上传到服务器或者保存本地，可以实现ILogAdapter接口来实现对应的逻辑。

> ILogAdapter 是一个接口，代表日志适配器，定义了与日志记录相关的操作，比如日志开关控制和日志信息行为出口。


```
export class UplaodLogAdapter implements ILogAdapter{

  // 控制是否上传    
  isLoggable(level: hilog.LogLevel, tag: string): boolean {
    return  true / false
  }
  
  // 实现上传逻辑
  log(level: hilog.LogLevel, tag: string, msg: string, ...args: ObjectOrNull[]): void {
      
  }

}
```

接着通过Logger的addLogAdapter()方法将UplaodLogAdapter实例添加到适配器容器中。

```
Logger.addLogAdapter(new UplaodLogAdapter())
```

## 工作流程图

Logger框架整个的流程图：


<center>

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/947f4b13189845fca93ea9613cd9e790.png)


</center>


LogPrinter负责管理日志适配器(ILogAdapter)和分发日志信息，Logger类是对外使用的入口，通过此类可以与不同的日志适配器进行交互，从而实现日志的记录和输出，符合依赖倒置原则，使得Logger类依赖于ILogAdapter接口，而非依赖具体的适配器实现，从而提高了代码的扩展性和维护性。


## 其他

记得将IDE的`soft-wrap`开关关闭，不然分割线会自动换行，出现错乱效果。




![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/51d905156f9248ab96120f6f90ac27d9.png)


## 源码

- https://gitee.com/common-apps/logger

**## 参考


- https://github.com/orhanobut/logger


