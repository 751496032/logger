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
    LogPrinter.globalConfig = config
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

  public static json2(tag: string, args: string | object): void {
    Logger.printer.json2(tag, args)
  }


  public static info(config: LogConfig, ...args: ObjectOrNull[]) {
    Logger.printer.info(config, ...args)
  }

  public static debug(config: LogConfig, ...args: ObjectOrNull[]) {
    Logger.printer.debug(config, ...args)
  }

  public static warn(config: LogConfig, ...args: ObjectOrNull[]) {
    Logger.printer.warn(config, ...args)
  }

  public static error(config: LogConfig, ...args: ObjectOrNull[]) {
    Logger.printer.error(config, ...args)
  }

  public static fatal(config: LogConfig, ...args: ObjectOrNull[]) {
    Logger.printer.fatal(config, ...args)
  }

  public static json3(config: LogConfig, args: string | object): void {
    Logger.printer.json3(config, args)
  }


}