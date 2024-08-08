/**
 * @author: HZWei
 * @date: 2024/7/28
 * @desc:
 */
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ObjectOrNull } from '../common/Types'

export interface ILogAdapter {

  isLoggable(level: hilog.LogLevel, tag: string): boolean

  log(level: hilog.LogLevel, tag: string, msg: string, ...args: ObjectOrNull[]): void

}