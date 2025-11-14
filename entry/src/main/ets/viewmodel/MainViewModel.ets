import { getLogger } from "@hzw/logger"

/**
 * @author: HZWei
 * @date: 2025/11/14
 * @desc:
 */
const logger = getLogger("MainViewModel", (config) => {
  config.ignoreStackKeywords = ["incrementInternal"]
  config.domain = 0x1122
})
@ObservedV2
export class MainViewModel {
  @Trace counter: number = 0

  /**
   * 自增1
   */
  increment() {
    this.incrementInternal()
    logger.d("click increment", this.counter)
  }

  private incrementInternal() {
    this.counter++
    logger.d("click incrementInternal", this.counter)
  }
}