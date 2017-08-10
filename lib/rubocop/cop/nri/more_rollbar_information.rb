# frozen_string_literal: true

module RuboCop
  module Cop
    module Nri
      ##
      # Catches uses of Rollbar missing `advisory` and `impact` keywords.
      class MoreRollbarInformation < Cop
        MSG = 'Must include advisory and impact as keyword arguments.'

        def_node_matcher :missing_hash?, <<-PATTERN
          {
            (send (const nil :Rollbar) {:critical :error})
            (send (const nil :Rollbar) {:critical :error} ... !(hash ...))
          }
        PATTERN

        def_node_matcher :hash, <<-PATTERN
          (send (const nil :Rollbar) {:critical :error} ... (hash $...))
        PATTERN

        def_node_matcher :advisory?, <<-PATTERN
          (pair (sym :advisory) _)
        PATTERN

        def_node_matcher :impact?, <<-PATTERN
          (pair (sym :impact) _)
        PATTERN

        def on_send(node)
          on_missing_hash(node)
          on_hash(node)
        end

        private

        def advisory_key?(pairs)
          pairs.any?(&method(:advisory?))
        end

        def all_keys?(pairs)
          advisory_key?(pairs) && impact_key?(pairs)
        end

        def impact_key?(pairs)
          pairs.any?(&method(:impact?))
        end

        def on_hash(node)
          hash(node) do |pairs|
            add_offense(node, :expression) unless all_keys?(pairs)
          end
        end

        def on_missing_hash(node)
          add_offense(node, :expression) if missing_hash?(node)
        end
      end
    end
  end
end
