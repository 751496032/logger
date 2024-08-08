/**
 * @author: HZWei
 * @date: 2024/5/20
 * @desc:
 */

export interface LogConfig {
  readonly domain: number
  readonly tag?: string
  readonly debug: boolean
  readonly  fullStack?: boolean
  readonly showStack?: boolean
  readonly showDivider?: boolean,
}