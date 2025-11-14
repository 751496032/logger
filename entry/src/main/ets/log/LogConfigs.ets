/**
 * @author: HZWei
 * @date: 2024/12/18
 * @desc:
 */
import { LogConfig } from "@hzw/logger";

export namespace LogConfigs {

  export const globalConfig: LogConfig = {
    domain: 0x6677,
    showStack: true,
    isPrintFullStack: false,
    showDivider: true,
    debug: true,
    tag: 'yy'
  } as LogConfig

  export const hzwConfig: LogConfig =
    {
      domain: 0x6688,
      showStack: false,
      isPrintFullStack: false,
      showDivider: false,
      debug: true,
      tag: 'hzw'
    } as LogConfig


}