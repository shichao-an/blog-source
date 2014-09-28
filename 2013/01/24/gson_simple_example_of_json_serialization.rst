GSON simple example of JSON deserialization and use of parser
=============================================================

It seems that JSON-lib is a bit old and requires many dependencies, so I try to have a quick look at Google GSON, which has become the most popular tools for JSON in Java.

.. highlight:: json

::

    {
        "id": "10001",
        "time": "20.1",
        "result": [{
            "name": "John",
            "age": "22"
            },{
            "name": "Jim",
            "age": "23"
            },{
            "name": "Rachel",
            "age": "21"
            }]
    }

GsonTest.java

.. highlight:: java

::

    package com.gson.test;
    import com.google.gson.*;
    import org.apache.commons.io.FileUtils;
    import java.io.*;
     
    public class GsonTest {
     
        public static void main(String[] args) {
            // Deserialize JSON to object
            String txt = "{'name': 'James', 'age': '25'}";
            Gson gson = new Gson();
            Person person = gson.fromJson(txt, Person.class);
            System.out.println(person.toString());
            /*
             * name: James
             * age: 25
             *
             * */
             
            String r = readToString("/path/to/json.txt");
     
            // Parse JSON directly (into JsonElement)
            JsonParser parser = new JsonParser();
            JsonObject obj = (JsonObject)parser.parse(r);
            JsonElement id = obj.get("id");
            System.out.println(id); // Prints "10001"
             
            JsonArray arr = obj.get("result").getAsJsonArray();
            JsonElement p = arr.get(0);
            System.out.println(p); // Prints {"name": "John","age": "22"}
        }
         
        public static String readToString(String path){
            File f = new File(path);
            try{
                String r = FileUtils.readFileToString(f, "UTF-8");
                return r;
            }
            catch (IOException e){
                 e.printStackTrace();
                 return null;
            }
        }
    }
     
    class Person{
        private String name;
        private String age;
         
        public Person(String name, String age){
            this.name = name;
            this.age = age;
        }
         
        @Override
        public String toString(){
             StringBuilder sb = new StringBuilder();
             sb.append("name: " + name + "\n");
             sb.append("age: " + age + "\n");
             return sb.toString();
        }
         
    }

.. author:: default
.. categories:: none
.. tags:: Java
.. comments::
