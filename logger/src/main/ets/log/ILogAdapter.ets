/**
 * @author: HZWei
 * @date: 2024/7/28
 * @desc:
 */
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ObjectOrNull } from '../common/Types'

export interface ILogAdapter {

 /**
  * 控制是否输出日志
  * @param level
  * @param tag
  * @returns
  */
  isLoggable(level: hilog.LogLevel, tag: string): boolean

  /**
   * 日志统一输出口
   * @param level 日志级别
   * @param tag  tag
   * @param msg   日志转换为字符串后的形态
   * @param args  日志的原始类型
   */
  log(level: hilog.LogLevel, tag: string, msg: string, ...args: ObjectOrNull[]): void

}