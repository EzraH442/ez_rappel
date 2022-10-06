// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  const User({required this.id, required this.username});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
    };
  }

  User copyWith({int? id, String? username}) => User(
        id: id ?? this.id,
        username: username ?? this.username,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User && other.id == this.id && other.username == this.username);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
  }) : username = Value(username);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
    });
  }

  UsersCompanion copyWith({Value<int>? id, Value<String>? username}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, username];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  final int user;
  const Tag({required this.id, required this.name, required this.user});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['user'] = Variable<int>(user);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      user: Value(user),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      user: serializer.fromJson<int>(json['user']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'user': serializer.toJson<int>(user),
    };
  }

  Tag copyWith({int? id, String? name, int? user}) => Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        user: user ?? this.user,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, user);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.user == this.user);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> user;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.user = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int user,
  })  : name = Value(name),
        user = Value(user);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? user,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (user != null) 'user': user,
    });
  }

  TagsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? user}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      user: user ?? this.user,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int> user = GeneratedColumn<int>(
      'user', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, user];
  @override
  String get aliasedName => _alias ?? 'tags';
  @override
  String get actualTableName => 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      user: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user'])!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Wordpair extends DataClass implements Insertable<Wordpair> {
  final int id;
  final String first;
  final String second;
  final int user;
  const Wordpair(
      {required this.id,
      required this.first,
      required this.second,
      required this.user});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first'] = Variable<String>(first);
    map['second'] = Variable<String>(second);
    map['user'] = Variable<int>(user);
    return map;
  }

  WordpairsCompanion toCompanion(bool nullToAbsent) {
    return WordpairsCompanion(
      id: Value(id),
      first: Value(first),
      second: Value(second),
      user: Value(user),
    );
  }

  factory Wordpair.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wordpair(
      id: serializer.fromJson<int>(json['id']),
      first: serializer.fromJson<String>(json['first']),
      second: serializer.fromJson<String>(json['second']),
      user: serializer.fromJson<int>(json['user']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'first': serializer.toJson<String>(first),
      'second': serializer.toJson<String>(second),
      'user': serializer.toJson<int>(user),
    };
  }

  Wordpair copyWith({int? id, String? first, String? second, int? user}) =>
      Wordpair(
        id: id ?? this.id,
        first: first ?? this.first,
        second: second ?? this.second,
        user: user ?? this.user,
      );
  @override
  String toString() {
    return (StringBuffer('Wordpair(')
          ..write('id: $id, ')
          ..write('first: $first, ')
          ..write('second: $second, ')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, first, second, user);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wordpair &&
          other.id == this.id &&
          other.first == this.first &&
          other.second == this.second &&
          other.user == this.user);
}

class WordpairsCompanion extends UpdateCompanion<Wordpair> {
  final Value<int> id;
  final Value<String> first;
  final Value<String> second;
  final Value<int> user;
  const WordpairsCompanion({
    this.id = const Value.absent(),
    this.first = const Value.absent(),
    this.second = const Value.absent(),
    this.user = const Value.absent(),
  });
  WordpairsCompanion.insert({
    this.id = const Value.absent(),
    required String first,
    required String second,
    required int user,
  })  : first = Value(first),
        second = Value(second),
        user = Value(user);
  static Insertable<Wordpair> custom({
    Expression<int>? id,
    Expression<String>? first,
    Expression<String>? second,
    Expression<int>? user,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (first != null) 'first': first,
      if (second != null) 'second': second,
      if (user != null) 'user': user,
    });
  }

  WordpairsCompanion copyWith(
      {Value<int>? id,
      Value<String>? first,
      Value<String>? second,
      Value<int>? user}) {
    return WordpairsCompanion(
      id: id ?? this.id,
      first: first ?? this.first,
      second: second ?? this.second,
      user: user ?? this.user,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (first.present) {
      map['first'] = Variable<String>(first.value);
    }
    if (second.present) {
      map['second'] = Variable<String>(second.value);
    }
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordpairsCompanion(')
          ..write('id: $id, ')
          ..write('first: $first, ')
          ..write('second: $second, ')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }
}

class $WordpairsTable extends Wordpairs
    with TableInfo<$WordpairsTable, Wordpair> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordpairsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _firstMeta = const VerificationMeta('first');
  @override
  late final GeneratedColumn<String> first = GeneratedColumn<String>(
      'first', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _secondMeta = const VerificationMeta('second');
  @override
  late final GeneratedColumn<String> second = GeneratedColumn<String>(
      'second', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<int> user = GeneratedColumn<int>(
      'user', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, first, second, user];
  @override
  String get aliasedName => _alias ?? 'wordpairs';
  @override
  String get actualTableName => 'wordpairs';
  @override
  VerificationContext validateIntegrity(Insertable<Wordpair> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first')) {
      context.handle(
          _firstMeta, first.isAcceptableOrUnknown(data['first']!, _firstMeta));
    } else if (isInserting) {
      context.missing(_firstMeta);
    }
    if (data.containsKey('second')) {
      context.handle(_secondMeta,
          second.isAcceptableOrUnknown(data['second']!, _secondMeta));
    } else if (isInserting) {
      context.missing(_secondMeta);
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wordpair map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wordpair(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      first: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}first'])!,
      second: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}second'])!,
      user: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}user'])!,
    );
  }

  @override
  $WordpairsTable createAlias(String alias) {
    return $WordpairsTable(attachedDatabase, alias);
  }
}

class WordpairTag extends DataClass implements Insertable<WordpairTag> {
  final int wpId;
  final int tagId;
  const WordpairTag({required this.wpId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['wp_id'] = Variable<int>(wpId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  WordpairTagsCompanion toCompanion(bool nullToAbsent) {
    return WordpairTagsCompanion(
      wpId: Value(wpId),
      tagId: Value(tagId),
    );
  }

  factory WordpairTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordpairTag(
      wpId: serializer.fromJson<int>(json['wpId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wpId': serializer.toJson<int>(wpId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  WordpairTag copyWith({int? wpId, int? tagId}) => WordpairTag(
        wpId: wpId ?? this.wpId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('WordpairTag(')
          ..write('wpId: $wpId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wpId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordpairTag &&
          other.wpId == this.wpId &&
          other.tagId == this.tagId);
}

class WordpairTagsCompanion extends UpdateCompanion<WordpairTag> {
  final Value<int> wpId;
  final Value<int> tagId;
  const WordpairTagsCompanion({
    this.wpId = const Value.absent(),
    this.tagId = const Value.absent(),
  });
  WordpairTagsCompanion.insert({
    required int wpId,
    required int tagId,
  })  : wpId = Value(wpId),
        tagId = Value(tagId);
  static Insertable<WordpairTag> custom({
    Expression<int>? wpId,
    Expression<int>? tagId,
  }) {
    return RawValuesInsertable({
      if (wpId != null) 'wp_id': wpId,
      if (tagId != null) 'tag_id': tagId,
    });
  }

  WordpairTagsCompanion copyWith({Value<int>? wpId, Value<int>? tagId}) {
    return WordpairTagsCompanion(
      wpId: wpId ?? this.wpId,
      tagId: tagId ?? this.tagId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wpId.present) {
      map['wp_id'] = Variable<int>(wpId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordpairTagsCompanion(')
          ..write('wpId: $wpId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }
}

class $WordpairTagsTable extends WordpairTags
    with TableInfo<$WordpairTagsTable, WordpairTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordpairTagsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _wpIdMeta = const VerificationMeta('wpId');
  @override
  late final GeneratedColumn<int> wpId = GeneratedColumn<int>(
      'wp_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [wpId, tagId];
  @override
  String get aliasedName => _alias ?? 'wordpair_tags';
  @override
  String get actualTableName => 'wordpair_tags';
  @override
  VerificationContext validateIntegrity(Insertable<WordpairTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('wp_id')) {
      context.handle(
          _wpIdMeta, wpId.isAcceptableOrUnknown(data['wp_id']!, _wpIdMeta));
    } else if (isInserting) {
      context.missing(_wpIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  WordpairTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordpairTag(
      wpId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}wp_id'])!,
      tagId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $WordpairTagsTable createAlias(String alias) {
    return $WordpairTagsTable(attachedDatabase, alias);
  }
}

abstract class _$Wordbase extends GeneratedDatabase {
  _$Wordbase(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $WordpairsTable wordpairs = $WordpairsTable(this);
  late final $WordpairTagsTable wordpairTags = $WordpairTagsTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, tags, wordpairs, wordpairTags];
}
