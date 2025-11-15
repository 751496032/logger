/**
 * @author: HZWei
 * @date: 2024/7/28
 * @desc:
 */
import { ObjectOrNull } from '../common/Types'
import { LogConfig } from './LogConfig'

export interface IPrinter extends ILogPrinter {

  dt(tag: string, ...args: ObjectOrNull[]): void

  et(tag: string, ...args: ObjectOrNull[]): void

  it(tag: string, ...args: ObjectOrNull[]): void

  wt(tag: string, ...args: ObjectOrNull[]): void

  ft(tag: string, ...args: ObjectOrNull[]): void

  json2(tag: string, args: object | string): void

  debug(config: LogConfig, ...args: ObjectOrNull[]): void

  error(config: LogConfig, ...args: ObjectOrNull[]): void

  info(config: LogConfig, ...args: ObjectOrNull[]): void

  warn(config: LogConfig, ...args: ObjectOrNull[]): void

  fatal(config: LogConfig, ...args: ObjectOrNull[]): void

  json3?(config: LogConfig, args: object | string): void

}

export interface ILogPrinter {

  d(...args: ObjectOrNull[]): void

  e(...args: ObjectOrNull[]): void

  i(...args: ObjectOrNull[]): void

  w(...args: ObjectOrNull[]): void

  f(...args: ObjectOrNull[]): void

  json(args: object | string): void

}