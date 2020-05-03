---
title: post
author: Daniel
date: 2020-04-18 17:01:49
tags: neo4j
categories:
	- graph
	- neo4j
---


# Graph 基本概念 ： 

基本元素 ： 
1. Nodes ： 数据记录，对应实体，如一个人或一部电影就是一个Node。
2. Relationships ： Nodes 之间的关系，如两个人（ Node ） 之间是 父子关系 （ Relationship ）。
3. Properties ： 键值对属性集，如一个人的姓名（ name = daniel ),或一个关系的描述，如朋友关系的亲密度 （ rateing= 10 ）。
4. Labels ： （分组）标签，用于将多个 Nodes 归为一组，比如 Alice 和 Bob 都是学生，那么这两个 Nodes 可以都打上 Student Label。一个 Node 可能有 0-N Labels。 Labels 无 Properties。

与关系型数据库对应 ：
- Graph 		<--> Database
- Label 		<--> Table
- Node 			<--> Row
- Propertie 	<--> Field / Column
- Relationship 	<--> Join fields ??? (Not sure)

<!-- more  -->

元素表示 ： 
1. Nodes ：  圆；
2. Relationships ： 连线；
3. Properties ： 圈或线上的键值对文本；
4. Labels ： 圈的颜色；（ 有多个 Labels 可能要考虑别的展示方式）

备注 ： 
1. 相同的 Nodes 可以有不同的属性集；
2. 属性可以是 字符串、数值 或 布尔；
3. Neo4j can store billions of nodes；


# Cypher 

**Cypher** 是 Neo4j 的查询语言，可以理解为 SQL 与 My SQL 之间的关系。

``` cypher
:help 
```

## CREATE

Create a node : *CREATE (p:Person { name: "Emil", from: "Sweden"})*
> Added 1 label, created 1 node, set 3 properties, completed after 9 ms.

- p : 变量名，建议有，否则无法根据 label 查询到；
- Person ： label 名称。
- { name : XXX, from : XXX } : properties 属性集

如果没有设置变量名，执行 ： *CREATE (Person { name: "Daniel", from: "China"})*
> Created 1 node, set 3 properties, completed after 20 ms.
且 *MATCH (n:Person) RETURN n LIMIT 25* 查不到
*MATCH (n) RETURN n LIMIT 25* 能查到


## MATCH

Finding nodes : *MATCH (ee:Person) WHERE ee.name = "Emil" RETURN ee;*
查询

``` cypher
MATCH (ee:Person) WHERE ee.name = "Emil"
CREATE (js:Person { name: "Johan", from: "Sweden", learn: "surfing" }),
(ir:Person { name: "Ian", from: "England", title: "author" }),
(rvb:Person { name: "Rik", from: "Belgium", pet: "Orval" }),
(ally:Person { name: "Allison", from: "California", hobby: "surfing" }),
(ee)-[:KNOWS {since: 2001}]->(js),(ee)-[:KNOWS {rating: 5}]->(ir),
(js)-[:KNOWS]->(ir),(js)-[:KNOWS]->(rvb),
(ir)-[:KNOWS]->(js),(ir)-[:KNOWS]->(ally),
(rvb)-[:KNOWS]->(ally)
```


MATCH (ee:Person)-[:KNOWS]-(friends)
WHERE ee.name = "Emil" RETURN ee, friends



PROFILE MATCH (js:Person)-[:KNOWS]-()-[:KNOWS]-(surfer)
WHERE js.name = "Johan" AND surfer.hobby = "surfing"
RETURN DISTINCT surfer

EXPLAIN MATCH (js:Person)-[:KNOWS]-()-[:KNOWS]-(surfer)
WHERE js.name = "Johan" AND surfer.hobby = "surfing"
RETURN DISTINCT surfer


Movies and actors up to 4 "hops" away from Kevin Bacon

MATCH (bacon:Person {name:"Kevin Bacon"})-[*1..4]-(hollywood)
RETURN DISTINCT hollywood

MATCH p=shortestPath(
  (bacon:Person {name:"Kevin Bacon"})-[*]-(meg:Person {name:"Meg Ryan"})
)
RETURN p


MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(coActors),
      (coActors)-[:ACTED_IN]->(m2)<-[:ACTED_IN]-(cocoActors)
WHERE NOT (tom)-[:ACTED_IN]->()<-[:ACTED_IN]-(cocoActors) AND tom <> cocoActors
RETURN cocoActors.name AS Recommended, count(*) AS Strength ORDER BY Strength DESC




? PROFILE 和 EXPLAIN 的区别
？多个条件之间逻辑组合
- MATCH (nineties:Movie) WHERE nineties.released >= 1990 AND nineties.released < 2000 RETURN nineties.title


? 为什么会自动过滤掉 TOM Hanks 本人 
》 MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(coActors) RETURN coActors.name

