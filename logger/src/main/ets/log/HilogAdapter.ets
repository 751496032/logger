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
  private globalConfig: LogConfig
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
    this.globalConfig = config
  }

  isLoggable(level: hilog.LogLevel, tag: string): boolean {
    return this.globalConfig.debug
  }

  logByCustomConfig(level: hilog.LogLevel, config: LogConfig | undefined, msg: string, ...args: ObjectOrNull[]): void {
    const domain = config ? config.domain :this.globalConfig.domain > 0 ? this.globalConfig.domain : 0x0066
    const showDivider = config ? config.showDivider : this.globalConfig.showDivider
    const showStack = config ? config.showStack : this.globalConfig.showStack
    const isPrintFullStack = config ? config.isPrintFullStack : this.globalConfig.isPrintFullStack
    const tag = config? config.tag : this.globalConfig.tag

    let newMsg =  showDivider ? this.TOP_BORDER + '\n' : ''
    if (showStack) {
      const stackMsg = isPrintFullStack ? new Error().stack : (new Error().stack?.trim()?.split('\n').slice(-2).join('\n')) + '\n'
      if (stackMsg) {
        let stackLines = stackMsg.split('\n')
        stackLines.forEach((line, index) => {
          if (index !== stackLines.length - 1) {
            if (showDivider) {
              newMsg += this.HORIZONTAL_LINE + ' ' +  line.trim() + '\n'
            }else {
              newMsg +=  ' ' +  line.trim() + '\n'
            }
          }else {
            newMsg += line.trim()
          }

        })
      }
      if (showDivider) {
        newMsg += this.MIDDLE_BORDER + '\n'
      }
    }

    msg.split('\n').forEach((line, index) => {
      if (showDivider) {
        newMsg += this.HORIZONTAL_LINE + ' ' + line + '\n'
      }else {
        newMsg += ' ' + line + '\n'
      }
      if (this.globalConfig.cacheLineNum) {
        if (index > 0 && (index + 1) % (this.globalConfig.cacheLineNum) === 0) {
          this.realLog(level, tag, newMsg, domain, ...args)
          newMsg = ''
        }
      }
    })
    if (this.globalConfig.showDivider) {
      newMsg += this.BOTTOM_BORDER + '\n'
    }
    msg = newMsg
    this.realLog(level, tag, msg, domain, ...args)
  }

  realLog(level: hilog.LogLevel, tag: string | undefined, msg: string, domain: number, ...args: ObjectOrNull[]) {
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
   * @deprecated
   * @param level
   * @param tag
   * @param msg
   * @param args
   */
  log(level: hilog.LogLevel, tag: string, msg: string, ...args: ObjectOrNull[]): void {
    // msg = this.formatMsg(msg, this.SINGLE_DIVIDER.length + 20)

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