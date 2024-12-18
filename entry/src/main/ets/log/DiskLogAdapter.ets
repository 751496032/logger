import { ILogAdapter } from "logger";
import { ObjectOrNull } from "logger/src/main/ets/common/Types";
import hilog from "@ohos.hilog";

/**
 * @author: HZWei
 * @date: 2024/12/18
 * @desc:
 */
export class  DiskLogAdapter implements ILogAdapter{
  isLoggable(level: hilog.LogLevel, tag: string): boolean {
    return true;
  }

  log(level: hilog.LogLevel, tag: string, msg: string, ...args: ObjectOrNull[]): void {
    console.log('msg:', msg, 'args:', args)
  }

}