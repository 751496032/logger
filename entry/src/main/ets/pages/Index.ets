import { LogConfig, Logger } from 'logger';
import { ArrayList } from '@kit.ArkTS';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column({space:10}) {
      Button('打印日志').onClick((event: ClickEvent) => {
        const msg = 'Hello World';
        const msg2 = 'Hello Logger';
        Logger.i(msg)
        //
        const messages = [msg, msg2]
        Logger.d(messages)
        //
        const user = new UserInfo('HZWei', 18)
        Logger.w(user)
        Logger.e(user, messages, 12, true)

        Logger.json(user)

        const map = new Map<string, Object>()
        map.set('name', 'HZWei')
        map.set('age', '18')
        map.set('user', new UserInfo('HZWei', 20))
        Logger.f(map)

        const list = new ArrayList<string>()
        list.add('HZWei')
        list.add('XML')
        Logger.w(list)

        Logger.wt('hzw',20)

        // Logger.init({
        //   domain: 0x6666,
        //   showStack: false,
        //   fullStack: false,
        //   showDivider: true,
        //   debug:true,
        //   tag: 'xml'
        // } as LogConfig)
        // Logger.w('Hello World')


      })
    }
    .height('100%')
    .width('100%')
  }
}

class UserInfo {
  name: string
  age: number
  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }
}