# frozen_string_literal: true

require "test_helper"

module RediSearch
  class Search
    class TermTest < ActiveSupport::TestCase
      test "#to_s" do
        assert_equal "`term`", Term.new("term").to_s
      end

      test "fuzziness of 1 #to_s" do
        assert_equal "`%term%`", Term.new("term", fuzziness: 1).to_s
      end

      test "fuzziness < 0 || > 3 throws error" do
        assert_raise ActiveModel::ValidationError do
          Term.new("term", fuzziness: -1).to_s
        end
        assert_raise ActiveModel::ValidationError do
          Term.new("term", fuzziness: 4).to_s
        end
      end

      test "escapes backticks in term" do
        assert_equal "`te\`rm`", Term.new("te`rm").to_s
      end

      test "unsupported options throw error" do
        assert_raise ActiveModel::ValidationError do
          Term.new("term", random: true)
        end
      end

      test "support optional terms" do
        assert_equal "`~term`", Term.new("term", optional: true).to_s
      end

      test "support prefix term" do
        assert_equal "`hel*`", Term.new("hel", prefix: true).to_s
      end
    end
  end
end
