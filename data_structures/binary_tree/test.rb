# frozen_string_literal: true

require_relative 'lib/tree'

tree = Tree.new

numbers = Array.new(15) { rand(1..100) }
p numbers

tree.build_tree(numbers)
tree.pretty_print
puts "Is tree balanced?: #{tree.balanced?}"

puts 'Level Order'
tree.level_order { |d| p d }
puts 'Preorder'
tree.preorder { |d| p d }
puts 'Inorder'
tree.inorder { |d| p d }
puts 'Postorder'
tree.postorder { |d| p d }

tree.insert(101)
tree.insert(900)
tree.insert(630)
tree.insert(201)

tree.pretty_print
puts "Is tree balanced?: #{tree.balanced?}"

tree.rebalance
tree.pretty_print
puts "Is tree balanced?: #{tree.balanced?}"

puts 'Level Order but with iteration'
tree.level_order { |d| p d }
puts 'Preorder'
tree.preorder_loop { |d| p d }
puts 'Inorder'
tree.inorder_loop { |d| p d }
puts 'Postorder'
tree.postorder_loop { |d| p d }
