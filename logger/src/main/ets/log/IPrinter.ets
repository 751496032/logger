/**
 * @author: HZWei
 * @date: 2024/7/28
 * @desc:
 */
import { ObjectOrNull } from '../common/Types'

export interface IPrinter {

  d(...args: ObjectOrNull[]): void

  e(...args: ObjectOrNull[]): void

  i(...args: ObjectOrNull[]): void

  w(...args: ObjectOrNull[]): void

  f(...args: ObjectOrNull[]): void

  json(args: object | string): void

  dt(tag: string, ...args: ObjectOrNull[]): void

  et(tag: string, ...args: ObjectOrNull[]): void

  it(tag: string, ...args: ObjectOrNull[]): void

  wt(tag: string, ...args: ObjectOrNull[]): void

  ft(tag: string, ...args: ObjectOrNull[]): void

  json2(tag: string, args: object | string): void

}