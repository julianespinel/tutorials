defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = KV.Registry.start_link
    {:ok, registry: registry}
  end

  test "creates buckets", %{registry: registry} do
    # Assert bucket does not exist
    assert KV.Registry.lookup(registry, "shopping") == :error
    # Get the bucket
    KV.Registry.create(registry, "shopping")
    assert {:ok, bucket} = KV.Registry.lookup(registry, "shopping")
    # Test the bucket
    KV.Bucket.put(bucket, "milk", 1)
    assert KV.Bucket.get(bucket, "milk") == 1
  end

  test "removes bucket on exit", %{registry: registry} do
    # Create the bucket
    KV.Registry.create(registry, "shopping")
    # Get the bucket
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")
    Agent.stop(bucket)
    # Test the bucket is no longer in the registry
    assert KV.Registry.lookup(registry, "shopping") == :error
  end

end
