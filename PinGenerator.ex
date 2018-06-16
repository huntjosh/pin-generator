defmodule Pin.Generator do
  alias Pin.Validator, as: Validator

  @pin_upper_limit 9990
  @pin_lower_limit 9

  def generate(count) do
    pins = Enum.reduce(1..count, [], fn(x, pins) -> [next_pin(pins) | pins] end)
    IO.inspect(pins)
  end

  def next_pin(pins) do
    Stream.repeatedly(&random_pin/0)
    |> Enum.find((&valid_pin(pins, &1)))
  end

  def valid_pin(pins, pin) do
    !Enum.member?(pins, pin) and Validator.validate(pin)
  end

  def random_pin() do
    Enum.random(@pin_lower_limit..@pin_upper_limit)
  end
end

Pin.Generator.generate(100)
