defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, _} = KV.Registry.start_link(context.test)
    {:ok, registry: context.test}
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
    # Ensure the registry processed the DOWN message
    _ = KV.Registry.create(registry, "bogus")
    # Test the bucket is no longer in the registry
    assert KV.Registry.lookup(registry, "shopping") == :error
  end

  test "removes bucket on crash", %{registry: registry} do
    KV.Registry.create(registry, "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")
    # Crash the bucket
    Process.exit(bucket, :shutdown)
    # Wait for the bucket to be dead
    ref = Process.monitor(bucket)
    assert_receive {:DOWN, ^ref, _, _, _}
    # Ensure the registry processed the DOWN message
    _ = KV.Registry.create(registry, "bogus")
    # Check the bucket has been removed
    assert KV.Registry.lookup(registry, "shopping") == :error
  end

end
