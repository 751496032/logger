/**
 * @author: HZWei
 * @date: 2024/5/19
 * @desc:
 */

function isString(v: unknown): boolean {
  return typeof v === "string"
}

function isNumber(v: unknown): boolean {
  return typeof v === "number"
}

function isBoolean(v: unknown): boolean {
  return typeof v === "boolean"
}

function isArray<T>(value: unknown): value is T[] {
  return Array.isArray(value);
}

function isFunction(v: unknown): boolean {
  return typeof v === 'function'
}

function isObject(v: unknown): boolean {
  return typeof v === 'object' && v != null
}

type ObjectOrNull = Object | undefined | null

export {
  isString, isNumber, isArray, isFunction, isObject ,isBoolean, ObjectOrNull
}



