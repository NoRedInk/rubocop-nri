# frozen_string_literal: true

module RuboCop
  module Cop
    module Nri
      ##
      # Catches uses of Rollbar missing `advisory`, `impact` and `value`.
      class MoreRollbarInformation < Cop
        MSG = 'Must include advisory, impact, and value.'

        def_node_matcher :missing_fields?, <<-PATTERN
          {(send (const nil :Rollbar) {:critical :error} ... (hash $...))}
        PATTERN

        def_node_matcher :advisory?, <<-PATTERN
          (pair (sym :advisory) _)
        PATTERN

        def_node_matcher :impact?, <<-PATTERN
          (pair (sym :impact) _)
        PATTERN

        def_node_matcher :value?, <<-PATTERN
          (pair (sym :value) _)
        PATTERN

        def on_send(node)
          missing_fields?(node) do |pairs|
            add_offense(node, :expression) unless all_fields?(pairs)
          end
        end

        private

        def all_fields?(pairs)
          pairs.any? { |pair| advisory?(pair) } &&
            pairs.any? { |pair| impact?(pair) } &&
            pairs.any? { |pair| value?(pair) }
        end
      end
    end
  end
end
