/**
 * @author: HZWei
 * @date: 2024/7/29
 * @desc:
 */
import { ILogAdapter } from './ILogAdapter';
import hilog from '@ohos.hilog';
import { LogConfig } from './LogConfig';
import { ObjectOrNull } from '../common/Types';

export class HilogAdapter implements ILogAdapter{
  private readonly format: string = '%{public}s, '
  private config: LogConfig
  private TOP_LEFT_CORNER = '┌';
  private BOTTOM_LEFT_CORNER = '└';
  private MIDDLE_CORNER = '├';
  private HORIZONTAL_LINE = '│';
  private DOUBLE_DIVIDER = "────────────────────────────────────────────";
  private SINGLE_DIVIDER = "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄";
  private TOP_BORDER = this.TOP_LEFT_CORNER + this.DOUBLE_DIVIDER + this.DOUBLE_DIVIDER;
  private BOTTOM_BORDER = this.BOTTOM_LEFT_CORNER + this.DOUBLE_DIVIDER + this.DOUBLE_DIVIDER;
  private MIDDLE_BORDER = this.MIDDLE_CORNER + this.SINGLE_DIVIDER + this.SINGLE_DIVIDER;


  constructor(config: LogConfig) {
    this.config = config
  }

  isLoggable(level: hilog.LogLevel, tag: string): boolean {
    return this.config.debug
  }

  log(level: hilog.LogLevel, tag: string, msg: string, ...args: ObjectOrNull[]): void {
    msg = this.formatMsg(msg, this.SINGLE_DIVIDER.length + 20)
    let newMsg =  this.config.showDivider ? this.TOP_BORDER + '\n' : ''
    if (this.config.showStack) {
      const stackMsg = this.config.fullStack ? new Error().stack : (new Error().stack?.trim()?.split('\n').slice(-2).join('\n')) + '\n'
      if (stackMsg) {
        let stackLines = stackMsg.split('\n')
        stackLines.forEach((line, index) => {
          if (index !== stackLines.length - 1) {
            if (this.config.showDivider) {
              newMsg += this.HORIZONTAL_LINE + ' ' +  line.trim() + '\n'
            }else {
              newMsg +=  ' ' +  line.trim() + '\n'
            }
          }else {
            newMsg += line.trim()
          }

        })
      }
      if (this.config.showDivider) {
        newMsg += this.MIDDLE_BORDER + '\n'
      }
    }

    msg.split('\n').forEach((line, index) => {
      if (this.config.showDivider) {
        newMsg += this.HORIZONTAL_LINE + ' ' + line + '\n'
      }else {
        newMsg += ' ' + line + '\n'
      }
    })
    if (this.config.showDivider) {
      newMsg += this.BOTTOM_BORDER + '\n'
    }
    msg = newMsg

    const domain = this.config.domain > 0 ? this.config.domain : 0x0066
    const format = '%{public}s'
    switch (level){
      case hilog.LogLevel.DEBUG:
        hilog.debug(domain, tag, format, msg)
        break
      case hilog.LogLevel.ERROR:
        hilog.error(domain, tag, format, msg)
        break
      case hilog.LogLevel.INFO:
        hilog.info(domain, tag, format, msg)
        break
      case hilog.LogLevel.WARN:
        hilog.warn(domain, tag, format, msg)
        break
      case hilog.LogLevel.FATAL:
        hilog.fatal(domain, tag, format, msg)
        break
    }
  }

  /**
   * 格式化消息，将每行消息按固定长度分割换行
   * @param msg
   * @param singleLineLength
   * @returns
   */
  private formatMsg(msg: string, singleLineLength: number) {
    if (!msg || msg.length <= singleLineLength) {
      return msg
    }
    // 匹配除除换行符之外的任意字符，匹配的字符长度为singleLineLength
    const regExp = new RegExp(`(.{1,${singleLineLength}})`, 'g');
    // 按换行符分割字符串
    const subs = msg.split('\n');
    const newLines = subs.map(sub => {
      if (sub.length > 0) {
        const subLines = sub.match(regExp);
        if (subLines) {
          // 用换行符分隔
          return subLines.join('\n');
        }
      }
      return sub;
    });
    return newLines.join('\n');
  }

  private getFormat(length: number): string {
    const f = this.format.repeat(length)
    const lastIndex = f.lastIndexOf(',')
    return f.substring(0, lastIndex)
  }


}