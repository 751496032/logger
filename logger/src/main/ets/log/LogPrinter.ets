/**
 * @author: HZWei
 * @date: 2024/7/28
 * @desc:
 */
import { isArray, isBoolean, isNumber, isObject, isString, ObjectOrNull } from '../common/Types';
import { ILogAdapter } from './ILogAdapter';
import { IPrinter } from './IPrinter';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { Logger } from './Logger';
import { LogConfig } from './LogConfig';
import { ArrayList } from '@kit.ArkTS';

export class LogPrinter implements IPrinter {

  private readonly TAG: string = 'Logger'
  private adapters = new Array<ILogAdapter>()

  d(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.DEBUG, this.TAG, false, ...args)
  }

  e(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.ERROR, this.TAG, false, ...args)
  }

  i(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.INFO, this.TAG, false, ...args)
  }

  w(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.WARN, this.TAG, false, ...args)
  }

  f(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.FATAL, this.TAG, false, ...args)
  }

  json(args: string | object): void {
    this.log(hilog.LogLevel.DEBUG, this.TAG, true, args)
  }

  dt(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.DEBUG, tag, false, ...args)
  }

  et(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.ERROR, tag, false, ...args)
  }

  it(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.INFO, tag, false, ...args)
  }

  wt(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.WARN, tag, false, ...args)
  }

  ft(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.FATAL, tag, false, ...args)
  }

  json2(tag: string, args: string | object): void {
    this.log(hilog.LogLevel.DEBUG, tag, true, args)
  }

  public addLogAdapter(adapter: ILogAdapter) {
    this.adapters.push(adapter)
  }

  public removeLogAdapter(adapter: ILogAdapter) {
    const index = this.adapters.indexOf(adapter)
    if (index !== -1) {
      this.adapters.splice(index, 1)
    }
  }

  public clearLogAdapter() {
    if (this.adapters.length > 0) {
      this.adapters.splice(0, this.adapters.length)
    }
  }


  private log(level: hilog.LogLevel, tag: string, isJson: boolean, ...args: ObjectOrNull[]) {
    if (args.length === 0) {
      return
    }
    if (this.adapters.length <= 0) {
      Logger.init({
        domain: 0x6666,
        showStack: true,
        fullStack: false,
        showDivider: true,
        debug:true,
        tag: this.TAG
      } as LogConfig)
    }
    const messages = this.getMessages([], isJson, ...args)
    this.adapters.forEach((adapter) => {
      if (adapter.isLoggable(level, tag)) {
        adapter.log(level, tag, messages.join(' '), ...args)
      }
    })
  }

  private getKV(map: Map<ObjectOrNull, ObjectOrNull>): string {
    if (map.size <= 0) {
      return ''
    }
    let str = ''
    map.forEach((value, key) =>{
      str += `${JSON.stringify(key)}=${JSON.stringify(value)}, `
    })
    return str.replace(/"/g, '').slice(0, -2)
  }

  private getMessages(params: string[], isJson: boolean = false, ...args: ObjectOrNull[]): string[] {
    args.forEach((v) => {
      if (isObject(v) || isArray(v) || isNumber(v) || isBoolean(v)) {
        if (isJson && isObject(v)) {
          params.push(JSON.stringify(v, null, 2))
        } else if (v instanceof Map) {
          params.push(this.getKV(v))
        } else {
          params.push(JSON.stringify(v))
        }

      } else if (v === undefined) {
        params.push('undefined')
      } else if (v === null) {
        params.push('null')
      } else if (isString(v)) {
        if (isJson) {
          params.push(JSON.stringify(v, null, 2))
        } else {
          params.push(v.toString())
        }
      }
    })
    return params
  }
}