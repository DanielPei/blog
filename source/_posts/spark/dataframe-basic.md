---
title: Spark dataframe basic
author: Daniel
date: 2020-04-11 15:00:18
tags:
categories:
	- spark
	- dataframe
---

# 简介
本篇主要记录 **pyspark** 操作 **dataframe** 的常见基本操作，以 **hive** 作为数据源进行示例。


# Hive 数据源相关信息
查看 hive 数据源信息
``` python
# 查看 hive 数据库
spark.sql("show databases;").show()

```

# Dataframe 常用操作

## Dataframe 自定义 UDF 函数
通过 **udf** （ User defined function ） 可以将自定义的业务逻辑函数作用于 *dataframe*。

``` python
# 引入依赖
from pyspark.sql.functions import udf
from pyspark.sql.types import StringType, BooleanType, IntegerType

# 创建测试数据
data = [(1, 1.0, None), (1, 2.0,5), (2, 3.0,5), (2, 5.0,5), (2, 10.0,5)]
cols = ("id", "v", "f")
df = spark.createDataFrame(data, cols)

    +---+----+----+
    | id|   v|   f|
    +---+----+----+
    |  1| 1.0|null|
    |  1| 2.0|   5|
    |  2| 3.0|   5|
    |  2| 5.0|   5|
    |  2|10.0|   5|
    +---+----+----+

# 1. 定义业务逻辑函数
def is_even(val):
    try:
        return (val%2) == 0
    except Exception as e:
        return False

# 2. 封装 udf
udf_is_even = udf(is_even, returnType= BooleanType())

# 3. 使用 udf ：新增一个 Boolean 类型的列 is_v_even 表示 v 列是否是偶数。
df.withColumn("is_v_even", udf_is_even(df["v"])).show()

	+---+----+----+---------+
	| id|   v|   f|is_v_even|
	+---+----+----+---------+
	|  1| 1.0|null|    false|
	|  1| 2.0|   5|     true|
	|  2| 3.0|   5|    false|
	|  2| 5.0|   5|    false|
	|  2|10.0|   5|     true|
	+---+----+----+---------+

```

## Dataframe column 操作

### 重命名列 withColumnRenamed

> **withColumnRenamed(existing, new)** : Returns a new DataFrame by renaming an existing column. This is a no-op if schema doesn’t contain the given column name.
	**Parameters:**
	- existing – string, name of the existing column to rename.
	- new – string, new name of the column.


	``` python
	# 将 v 列重命名为 val 
	df = df.withColumnRenamed("v", "val")
	```

### 新增列 withColumn

> **withColumn(colName, col)** : Returns a new DataFrame by adding a column or replacing the existing column that has the same name.
The column expression must be an expression over this DataFrame; attempting to add a column from some other dataframe will raise an error.
	**Parameters:**
	- colName – string, name of the new column.
	- col – a Column expression for the new column.

``` python
df.show()

	+---+----+----+
	| id|   v|   f|
	+---+----+----+
	|  1| 1.0|null|    
	|  2|10.0|   5|
	+---+----+----+

# 使用 udf ：新增一个 Boolean 类型的列 is_v_even 表示 v 列是否是偶数。
df.withColumn("is_v_even", udf_is_even(df["v"])).show()

	+---+----+----+---------+
	| id|   v|   f|is_v_even|
	+---+----+----+---------+
	|  1| 1.0|null|    false|
	|  2|10.0|   5|     true|
	+---+----+----+---------+

# 新增一列，并填充固定值
from pyspark.sql.functions import lit

df.withColumn("constants", lit("Hello")).show()

	+---+----+----+---------+
	| id|   v|   f|constants|
	+---+----+----+---------+
	|  1| 1.0|null|    Hello|
	|  2|10.0|   5|    Hello|
	+---+----+----+---------+

# 新增一列，并用其他几列的数据联合填充
from pyspark.sql.functions import concat_ws

df.withColumn("v+f", df["v"] + df["f"]).show()

	+---+----+----+----+
	| id|   v|   f| v+f|
	+---+----+----+----+
	|  1| 1.0|null|null|	# null 与 数值的加法，结果为 null
	|  2|10.0|   5|15.0|
	+---+----+----+----+

df.withColumn("Concat_v_f", concat_ws("-", *["v","f", "id"])).show()

	+---+----+----+----------+
	| id|   v|   f|Concat_v_f|
	+---+----+----+----------+
	|  1| 1.0|null|     1.0-1|	# null 值会忽略
	|  2|10.0|   5|  10.0-5-2|
	+---+----+----+----------+

```

### 替换列
新增列时，如果使用的列名是已存在的列，则会替换该列。


# FAQ
**1. 两个 df union 后出现数据错乱。**
DataFrame 的 union 操作，只会按照 cols 的顺序进行两个 DataFrame 的合并，忽略 DataFrame 的列名，如果两个 DataFrame 的每个列的顺序不是完全一致的，则会出现数据的错乱。 
如希望按列匹配合并，应使用 **unionByName** ( pyspark 2.3 引入)。
``` python
	df_1 = spark.createDataFrame([("Dan", 28)],("name", "age"))
	df_2 = spark.createDataFrame([(18, "John")],("age", "name"))

	df_1.union(df_2).show()

		+----+----+
		|name| age|
		+----+----+
		| Dan|  28|
		|  18|John|
		+----+----+

```

# 参考资料

