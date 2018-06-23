require 'spec_helper'
require_relative '../StringCalculator'


RSpec.describe StringCalculator do
  subject(:calculator) { StringCalculator.new }
  
  context 'argument is empty string' do
    it 'should return 0' do
      expect(calculator.run('')).to eq(0)
    end
  end
  
  context 'argument has a numeric string' do
    [
      { input: '1', output: 1 },
      { input: '10', output: 10 },
      { input: '100', output: 100 }
    ].each do |example|
      it 'should convert to number' do
        expect(calculator.run(example[:input])).to eq(example[:output]) 
      end
    end
  end
  
  context "argument has a numeric string having two numbers seperated by ',' " do
    [
      { input: '1,2', output: 3 },
      { input: '10,20', output: 30 },
      { input: '100,300', output: 400 }
    ].each do |example|
      it 'should return the sum of two numbers' do
        expect(calculator.run(example[:input])).to eq(example[:output])
      end
    end
  end

  context "argument has a numeric string having arbitrary numbers seperated by ','" do
    [
      { input: (1..10).map(&:to_s).join(','), output: 55 },
      { input: (101..110).map(&:to_s).join(','), output: 1055 }
    ].each do |example|
      it 'should return the sum of two numbers' do
        expect(calculator.run(example[:input])).to eq(example[:output]) 
      end
    end
  end

  context "argument has a numeric string having arbitrary numbers seperated by ',' or '\\n' " do
    [
      { input: '1,2\n3', output: 6 },
      { input: '10\n20', output: 30 },
      { input: '100\n200,300\n400', output: 1000 }
    ].each do |example|
      it 'should return the sum of numbers' do
        expect(calculator.run(example[:input])).to eq(example[:output])
      end
    end
  end

  context 'argument is invalid' do
    context "argment string ended with either ',' or '\n'" do
      [
        { input: '1,2\n' },
        { input: '10,\n' },
        { input: '100,' }
      ].each do |example|
        it 'should raise InvalidArgument exception' do
          expect { calculator.run(example[:input]) }.to raise_error(ArgumentError)
        end
      end
    end

    context "argment string ended with either ',' or '\n'" do
      [
        { input: '-1,2\n' },
        { input: '//%\n-1%2%3' },
        { input: '//$\n1$2$3$-10' }
      ].each do |example|
        it 'should raise InvalidArgument exception' do
          expect { calculator.run(example[:input]) }.to raise_error(ArgumentError)
        end
      end
    end
  end

  context "user like to use custom delimeter character with format '//delimeter\nnumbers' e.g '//;\n1;2' " do
    [
      { input: '//;\n1;2', output: 3 },
      { input: '//%\n1%2%3', output: 6 },
      { input: '//$\n1$2$3$10', output: 16 }
    ].each do |example|
      it 'should return the sum of numbers' do
        expect(calculator.run(example[:input])).to eq(example[:output])
      end
    end
  end

  context 'numbers are bigger than 1000' do
    [
      { input: '1,10,1000', output: 1011 },
      { input: '1,10,1001', output: 11 },
      { input: '10,30,2000', output: 40 }
    ].each do |example|
      it 'should return the sum of numbers' do
        expect(calculator.run(example[:input])).to eq(example[:output])
      end
    end
  end
end
