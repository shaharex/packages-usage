import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_channel/models/post_model.dart';

class HttpPage extends StatefulWidget {
  const HttpPage({super.key});

  @override
  State<HttpPage> createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  late Future<Post> _futurePost;
  // using dio 

  // making http request using the dart:convert and dart:io from the flutter
  HttpClient client = HttpClient();
  HttpClient clientPost = HttpClient();

  // get request
  Future<Post> httpGetRequest() async {
    try {
      HttpClientRequest request = await client
          .getUrl(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        String responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> data = jsonDecode(responseBody);
        print(data);
        return Post.fromJson(data); 
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
    }
    throw Exception('Failed to load Post');
  }

  // post request
  // Future<void> httpPostRequest() async {
  //   try {
  //     HttpClientRequest request = await clientPost.postUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts/"));

  //     Map<String, dynamic> postData = {
        
  //       'userId': 1,
  //       'id:': 2,
  //       'title': 'foo',
  //       'body': 'bar',
  //     };

  //     request.add(utf8.encode(jsonEncode(postData)));

  //     HttpClientResponse response = await request.close();

  //     if (response.statusCode == HttpStatus.created) {
  //       String responseBody = await response.transform(utf8.decoder).join();
  //       print(responseBody);

  //       print("it's working");
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }

  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     client.close();
  //   } 
  //   throw Exception('Failed to post the data');
    
  // }

  @override
  void initState() {
    _futurePost = httpGetRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Post>(
          future: _futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Post Contents',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(snapshot.data!.title),
                      Text(snapshot.data!.body),
                      Text('This is id ${snapshot.data!.id}'),
                      Text('This is userId ${snapshot.data!.userId}')
                    ],
                  ));
            } else {
              return Text(
                  'Sorry, sir. My intentions were good, but this is not in my pleasure: ${snapshot.error}');
            }
            
          }),
    );
  }
}
