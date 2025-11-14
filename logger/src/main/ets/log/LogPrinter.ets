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
import { ObjectUtil } from '../common/ObjectUtil';
import { HilogAdapter } from './HilogAdapter';

export class LogPrinter implements IPrinter {
  static readonly TAG: string = 'Logger'
  private adapters = new Array<ILogAdapter>()
  static ignoreStackTraceKeywords = ['logger/src/main/ets/common', 'logger/src/main/ets/log']
  static globalConfig: LogConfig = {
    domain: 0x6666,
    showStack: true,
    isPrintFullStack: false,
    showDivider: true,
    debug: true,
    tag: LogPrinter.TAG,
    ignoreStackKeywords: LogPrinter.ignoreStackTraceKeywords,
  }

  d(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.DEBUG, LogPrinter.globalConfig, false, ...args)
  }

  e(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.ERROR, LogPrinter.globalConfig, false, ...args)
  }

  i(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.INFO, LogPrinter.globalConfig, false, ...args)
  }

  w(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.WARN, LogPrinter.globalConfig, false, ...args)
  }

  f(...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.FATAL, LogPrinter.globalConfig, false, ...args)
  }

  json(args: string | object): void {
    this.log(hilog.LogLevel.DEBUG, LogPrinter.globalConfig, true, args)
  }

  dt(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.DEBUG, this.getLogConfigByTag(tag), false, ...args)
  }

  et(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.ERROR, this.getLogConfigByTag(tag), false, ...args)
  }

  it(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.INFO, this.getLogConfigByTag(tag), false, ...args)
  }

  wt(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.WARN, this.getLogConfigByTag(tag), false, ...args)
  }

  ft(tag: string, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.FATAL, this.getLogConfigByTag(tag), false, ...args)
  }

  json2(tag: string, args: string | object): void {
    this.log(hilog.LogLevel.DEBUG, this.getLogConfigByTag(tag), true, args)
  }


  debug(config: LogConfig, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.DEBUG, config, false, ...args)
  }

  error(config: LogConfig, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.ERROR, config, false, ...args)
  }

  info(config: LogConfig, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.INFO, config, false, ...args)
  }

  warn(config: LogConfig, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.WARN, config, false, ...args)
  }

  fatal(config: LogConfig, ...args: ObjectOrNull[]): void {
    this.log(hilog.LogLevel.FATAL, config, false, ...args)
  }

  json3(config: LogConfig, args: string | object): void {
    this.log(hilog.LogLevel.FATAL, config, true, args)
  }


  public addLogAdapter(adapter: ILogAdapter) {
    if (!this.adapters.includes(adapter)){
      const targetClass  = this.adapters.find((item) => item.constructor.name == adapter.constructor.name)
      if (!targetClass) {
        this.adapters.push(adapter)
      }

    }

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

  private getLogConfigByTag(tag: string): LogConfig {
    const config = ObjectUtil.shallowCopy(LogPrinter.globalConfig) as LogConfig
    config.tag = tag
    return config
  }


  private log(level: hilog.LogLevel, config: LogConfig, isJson: boolean, ...args: ObjectOrNull[]) {
    let tag = config.tag
    tag = tag ? tag : LogPrinter.TAG
    config.tag = tag
    if (args.length === 0) {
      return
    }
    if (this.adapters.length <= 0) {
      Logger.init({
        domain: 0x6666,
        showStack: true,
        isPrintFullStack: false,
        showDivider: true,
        debug: true,
        tag: LogPrinter.TAG
      } as LogConfig)
    }
    const messages = this.getMessages([], isJson, ...args)
    this.adapters.forEach((adapter) => {
      if (adapter.isLoggable(level, tag!)) {
        adapter.log(level, tag!, messages.join(' '), ...args)
        if (adapter instanceof HilogAdapter) {
          adapter.logByCustomConfig(level, config, messages.join(' '), ...args)
        }
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