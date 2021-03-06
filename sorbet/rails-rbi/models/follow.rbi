# This is an autogenerated file for dynamic methods in Follow
# Please rerun bundle exec rake rails_rbi:models[Follow] to regenerate.

# typed: strong
module Follow::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Follow::GeneratedAttributeMethods
  sig { returns(ActiveSupport::TimeWithZone) }
  def created_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def created_at=(value); end

  sig { returns(T::Boolean) }
  def created_at?; end

  sig { returns(T.nilable(Integer)) }
  def follower_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def follower_id=(value); end

  sig { returns(T::Boolean) }
  def follower_id?; end

  sig { returns(T.nilable(Integer)) }
  def following_id; end

  sig { params(value: T.nilable(T.any(Numeric, ActiveSupport::Duration))).void }
  def following_id=(value); end

  sig { returns(T::Boolean) }
  def following_id?; end

  sig { returns(Integer) }
  def id; end

  sig { params(value: T.any(Numeric, ActiveSupport::Duration)).void }
  def id=(value); end

  sig { returns(T::Boolean) }
  def id?; end

  sig { returns(ActiveSupport::TimeWithZone) }
  def updated_at; end

  sig { params(value: T.any(Date, Time, ActiveSupport::TimeWithZone)).void }
  def updated_at=(value); end

  sig { returns(T::Boolean) }
  def updated_at?; end
end

module Follow::GeneratedAssociationMethods
  sig { returns(::User) }
  def follower; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def build_follower(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_follower(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_follower!(*args, &block); end

  sig { params(value: ::User).void }
  def follower=(value); end

  sig { returns(::User) }
  def following; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def build_following(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_following(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::User).void)).returns(::User) }
  def create_following!(*args, &block); end

  sig { params(value: ::User).void }
  def following=(value); end
end

module Follow::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Follow]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Follow]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Follow]) }
  def find_n(*args); end

  sig { params(id: Integer).returns(T.nilable(Follow)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Follow) }
  def find_by_id!(id); end
end

class Follow < ApplicationRecord
  include Follow::GeneratedAttributeMethods
  include Follow::GeneratedAssociationMethods
  extend Follow::CustomFinderMethods
  extend Follow::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(Follow::ActiveRecord_Relation, Follow::ActiveRecord_Associations_CollectionProxy, Follow::ActiveRecord_AssociationRelation) }
end

module Follow::QueryMethodsReturningRelation
  sig { returns(Follow::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Follow::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Follow::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Follow::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module Follow::QueryMethodsReturningAssociationRelation
  sig { returns(Follow::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Follow::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Follow::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Follow::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Follow::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

class Follow::ActiveRecord_Relation < ActiveRecord::Relation
  include Follow::ActiveRelation_WhereNot
  include Follow::CustomFinderMethods
  include Follow::QueryMethodsReturningRelation
  Elem = type_member(fixed: Follow)
end

class Follow::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Follow::ActiveRelation_WhereNot
  include Follow::CustomFinderMethods
  include Follow::QueryMethodsReturningAssociationRelation
  Elem = type_member(fixed: Follow)
end

class Follow::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Follow::CustomFinderMethods
  include Follow::QueryMethodsReturningAssociationRelation
  Elem = type_member(fixed: Follow)

  sig { params(records: T.any(Follow, T::Array[Follow])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Follow, T::Array[Follow])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Follow, T::Array[Follow])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Follow, T::Array[Follow])).returns(T.self_type) }
  def concat(*records); end
end
