class Author {
  final String id;
  final String fullname;
  final String intro;

  Author(this.id, this.fullname, this.intro);

  Author.fromJSON(Map<String, dynamic> json):
      id = json['id'], fullname = json['fullname'], intro = json['intro'];
}

class Mat {
  final String id;
  final String title;
  final String intro;
  final String content;
  late final String author;
  late final String aid;
  /*
  final int kind;
  final int format;
  final String intro;
  final String link;
  final String source;
  final int heat;
  final List<Author> authors;
  */

  Mat(this.id, this.title, this.intro, this.content, this.author, this.aid);

  Mat.fromJSON(Map<String, dynamic> json): id = json['id'], title = json['title'], intro = json['intro'], content = json['content'] {
    var authors = json['authors'];
    if (authors != null) {
      author = [for (var a in authors) a['fullname']].join(',');
      aid =  [for (var a in authors) a['id']].join(',');
    } else {
      author = '';
      aid = '';
    }
  }
}

/*
{
            "id": "Ri8qZtOb",
            "addtime": "2021-08-01T16:25:38.279853Z",
            "modtime": "2021-08-21T17:57:37.962729Z",
            "kind": 4,
            "format": 1,
            "title": "Go\u8bed\u8a00\u7cbe\u8fdb\u4e4b\u9053",
            "intro": "",
            "content": "1",
            "link": "",
            "source": "",
            "heat": 0,
            "authors": [
                {
                    "id": "00000001",
                    "lastname": "\u8d75",
                    "firstname": "\u666e\u660e",
                    "fullname": "\u8d75\u666e\u660e",
                    "intro": "\u4e00\u4e2a\u8ba4\u771f\u7684\u4eba",
                    "othernames": "\u8d75\u749f",
                    "avatar": "        ",
                    "active": true
                }
            ],
            "pids": "",
            "tags": null,
            "children": null,
            "isresource": false,
            "checksum": "",
            "entries": null
        },
 */
