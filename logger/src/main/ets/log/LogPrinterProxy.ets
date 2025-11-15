/**
 * @author: HZWei
 * @date: 2025/11/13
 * @desc:
 */
import { ObjectOrNull } from "../common/Types"
import { ILogPrinter } from "./IPrinter"
import { LogConfig, mergeConfig } from "./LogConfig"
import { LogPrinter } from "./LogPrinter"


export class LogPrinterProxy implements ILogPrinter {
  private printer: LogPrinter
  private _config: LogConfig = {} as LogConfig

  private constructor(printer: LogPrinter, config: LogConfig) {
    this.printer = printer
    this._config = config
  }

  static create(printer: LogPrinter, config: LogConfig): ILogPrinter {
    return new LogPrinterProxy(printer, config)
  }

  private get config(): LogConfig {
    return mergeConfig(this._config)
  }

  d(...args: ObjectOrNull[]): void {
    this.printer.debug(this.config, ...args)
  }

  e(...args: ObjectOrNull[]): void {
    this.printer.error(this.config, ...args)
  }

  i(...args: ObjectOrNull[]): void {
    this.printer.info(this.config, ...args)
  }

  w(...args: ObjectOrNull[]): void {
    this.printer.warn(this.config, ...args)
  }

  f(...args: ObjectOrNull[]): void {
    this.printer.fatal(this.config, ...args)
  }

  json(args: string | object): void {
    this.printer.json(this.config)
  }
}
