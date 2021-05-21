/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Note type in your schema. */
@immutable
class Note extends Model {
  static const classType = const _NoteModelType();
  final String id;
  final String title;
  final String content;
  final int color;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Note._internal(
      {@required this.id, this.title, this.content, this.color});

  factory Note({String id, String title, String content, int color}) {
    return Note._internal(
        id: id == null ? UUID.getUUID() : id,
        title: title,
        content: content,
        color: color);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Note &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        color == other.color;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Note {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$title" + ", ");
    buffer.write("content=" + "$content" + ", ");
    buffer.write("color=" + (color != null ? color.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Note copyWith({String id, String title, String content, int color}) {
    return Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        color: color ?? this.color);
  }

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        color = json['color'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content, 'color': color};

  static final QueryField ID = QueryField(fieldName: "note.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField COLOR = QueryField(fieldName: "color");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Note";
    modelSchemaDefinition.pluralName = "Notes";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Note.TITLE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Note.CONTENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Note.COLOR,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));
  });
}

class _NoteModelType extends ModelType<Note> {
  const _NoteModelType();

  @override
  Note fromJson(Map<String, dynamic> jsonData) {
    return Note.fromJson(jsonData);
  }
}
