/**
 * @author: HZWei
 * @date: 2024/5/20
 * @desc:
 */
import { LogConfig } from './LogConfig'
import { LogPrinter } from './LogPrinter'
import { HilogAdapter } from './HilogAdapter'
import { ILogAdapter } from './ILogAdapter'
import { ObjectOrNull } from '../common/Types'


export class Logger {
  private constructor() {
  }

  private static printer = new LogPrinter()

  /**
   * 初始化日志配置
   * @param config
   */
  static init(config: LogConfig) {
    Logger.addLogAdapter(new HilogAdapter(config))
  }

  static addLogAdapter(adapter: ILogAdapter) {
    Logger.printer.addLogAdapter(adapter)
  }

  static removeLogAdapter(adapter: ILogAdapter) {
    Logger.printer.removeLogAdapter(adapter)
  }

  static clearLogAdapter(){
    Logger.printer.clearLogAdapter()
  }

  public static i(...args: ObjectOrNull[]) {
    Logger.printer.i(...args)
  }

  public static d(...args: ObjectOrNull[]) {
    Logger.printer.d(...args)
  }

  public static w(...args: ObjectOrNull[]) {
    Logger.printer.w(...args)
  }

  public static e(...args: ObjectOrNull[]) {
    Logger.printer.e(...args)
  }

  public static f(...args: ObjectOrNull[]) {
    Logger.printer.f(...args)
  }

  public static json(args: string | object): void {
    Logger.printer.json(args)
  }


  public static it(tag: string, ...args: ObjectOrNull[]) {
    Logger.printer.it(tag, ...args)
  }

  public static dt(tag: string, ...args: ObjectOrNull[]) {
    Logger.printer.dt(tag, ...args)
  }

  public static wt(tag: string, ...args: ObjectOrNull[]) {
    Logger.printer.wt(tag, ...args)
  }

  public static et(tag: string, ...args: ObjectOrNull[]) {
    Logger.printer.et(tag, ...args)
  }

  public static ft(tag: string, ...args: ObjectOrNull[]) {
    Logger.printer.ft(tag, ...args)
  }

  public static jsont(tag: string, args: string | object): void {
    Logger.printer.json2(tag, args)
  }


}