/**
 * @author: HZWei
 * @date: 2025/11/14
 * @desc:
 */

export class LRUCache<K,V>{
  private cache: Map<K,V> = new Map();
  private capacity: number = 10;
  constructor(capacity: number = 10){
    this.capacity = capacity;
  }

  get size(): number {
    return this.cache.size;
  }

  clear(){
    this.cache.clear();
  }

  get(key: K): V | undefined {
    if (!this.cache.has(key)) {
      return undefined;
    }
    const value = this.cache.get(key)
    // LRU缓存核心，将最近访问的元素移动到队尾
    this.cache.delete(key);
    if (value) {
      this.cache.set(key, value);
    }
    return value;
  }

  set(key: K, value: V): void {
    if (this.cache.has(key)) {
      this.cache.delete(key);
    }
    // LRU缓存核心，如果超出容量，则删除最久未使用的元素，即队头元素
    if (this.size > this.capacity) {
      const key = Array.from(this.cache.keys())[0];
      this.cache.delete(key);
    }
    // 新数据放在队尾
    this.cache.set(key, value);
  }
}