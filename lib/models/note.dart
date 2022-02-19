class Note {
  final String id;
  final String content;

  Note(this.id, this.content);

  Note.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'];
}
/**
 * {
    "id": "8YXkbA01",
    "addtime": "2022-02-19T22:56:15.501801Z",
    "kind": 1,
    "format": 1,
    "title": "",
    "intro": "",
    "content": "sfdsdf",
    "link": "",
    "source": "",
    "heat": 0,
    "mid": "",
    "s": {
    "id": "LZlJgoYl",
    "mid": "00000132",
    "line": 4,
    "pos": 0
    },
    "e": {
    "id": "LZlJgoYl",
    "mid": "00000132",
    "line": 4,
    "pos": 0
    },
    "section": 0,
    "scope": 2,
    "modtime": "",
    "Author": "",
    "Uploader": "",
    "authors": [
    {
    "id": "00000001",
    "lastname": "赵",
    "firstname": "普明",
    "fullname": "赵普明",
    "intro": "一个认真的人",
    "othernames": "赵璟",
    "avatar": "        ",
    "active": true
    }
    ],
    "Uploaders": null,
    "tags": null
    }
 */
