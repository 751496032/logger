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
}