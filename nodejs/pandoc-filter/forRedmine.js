#!/usr/bin/env node

const pandoc = require('pandoc-filter')
const RawBlock = pandoc.RawBlock
const Str = pandoc.Str

const action = (key, value, format, meta) => {
  if (key === 'Str') {
    // return Str(value.replace('&#45', '-'))
    return Str(value
      .replace('->', '→')
      .replace('=>', '⇒'))
  }
  if (key === 'CodeBlock') {
    let [ [ , lang ], code ] = value
    const syntax = (lang.length) ? ` class="${lang}"` : ''
    return RawBlock('html', `<pre><code${syntax}>\n${code}\n</code></pre>\n`)
  }
}

pandoc.toJSONFilter(action)
