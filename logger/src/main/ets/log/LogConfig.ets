/**
 * @author: HZWei
 * @date: 2024/5/20
 * @desc:
 */

export interface LogConfig {
  domain: number
  tag?: string
  debug: boolean
  isPrintFullStack?: boolean
  showStack?: boolean
  showDivider?: boolean,
  // 针对行数较多的日志，建议采用「分批循环输出」策略——每次输出指定行数，避免一次性打印全部内容导致截断/不全。例如设置每批输出50行，对于长日志，则会按「每50行一批」的节奏持续输出，直至所有内容打印完毕。
  cacheLineNum?: number
}