defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores a key and a value", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes a (key, value) given a key", %{bucket: bucket} do
    key = "milk"
    value = 3
    assert KV.Bucket.get(bucket, key) == nil
    KV.Bucket.put(bucket, key, value)
    assert KV.Bucket.get(bucket, key) == value
    KV.Bucket.delete(bucket, key)
    assert KV.Bucket.get(bucket, key) == nil
  end

end
